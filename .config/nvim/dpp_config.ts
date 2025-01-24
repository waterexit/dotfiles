import { type Dpp } from "jsr:@shougo/dpp-vim@~4.0.0/dpp";
import {
    type ContextBuilder,
    type ExtOptions,
    type Plugin,
} from "jsr:@shougo/dpp-vim@~4.0.0/types";
import {
    BaseConfig,
    type ConfigReturn,
} from "jsr:@shougo/dpp-vim@~4.0.0/config";
import type {
    Ext as TomlExt,
    Params as TomlParams,
} from "jsr:@shougo/dpp-ext-toml";
import type {
    Ext as LocalExt,
    Params as LocalParams,
} from "jsr:@shougo/dpp-ext-local";
import type { Denops } from "jsr:@denops/std@~7.3.0";
import * as fn from "jsr:@denops/std@~7.3.0/function";

type Toml = {
    hooks_file?: string;
    ftplugins?: Record<string, string>;
    plugins?: Plugin[];
};

type LazyMakeStateResult = {
    plugins: Plugin[];
    stateLines: string[];
};

export class Config extends BaseConfig {
    override async config(args: {
        denops: Denops;
        contextBuilder: ContextBuilder;
        basePath: string;
        dpp: Dpp;
    }): Promise<ConfigReturn> {
        args.contextBuilder.setGlobal({
            protocols: ["git"],
        });

        const [context, options] = await args.contextBuilder.get(args.denops);
        const protocols = {};
        const recordPlugins: Record<string, Plugin> = {};
        const ftplugins: Record<string, string> = {};
        const hooksFiles: string[] = [];
        const tomlfilesDir = "~/.config/nvim/toml/";
        const tomlPaths: string[] = await Promise.all(
            ["dpp", "syntax", "lsp", "ddc", "util"].map(async (
                name,
            ) => await fn.expand(
                args.denops,
                tomlfilesDir + name + ".toml",
            )),
        ) as string[];
        // Load toml plugins
        const [tomlExt, tomlOptions, tomlParams]: [
            TomlExt | undefined,
            ExtOptions,
            TomlParams,
        ] = await args.denops.dispatcher.getExt(
            "toml",
        ) as [TomlExt | undefined, ExtOptions, TomlParams];
        if (tomlExt) {
            const action = tomlExt.actions.load;

            const tomls: Toml[] = await Promise.all(
                tomlPaths.map(async (path) => {
                    // use toml
                    return action.callback({
                        denops: args.denops,
                        context,
                        options,
                        protocols,
                        extOptions: tomlOptions,
                        extParams: tomlParams,
                        actionParams: {
                            path: path,
                            options: {
                                lazy: false,
                            },
                        },
                    });
                }),
            );

            tomls.forEach((toml) => {
                for (const plugin of toml.plugins) {
                    recordPlugins[plugin.name] = plugin;
                }

                if (toml.ftplugins) {
                    for (const filetype of Object.keys(toml.ftplugins)) {
                        if (ftplugins[filetype]) {
                            ftplugins[filetype] += `\n${
                                toml.ftplugins[filetype]
                            }`;
                        } else {
                            ftplugins[filetype] = toml.ftplugins[filetype];
                        }
                    }
                }

                if (toml.hooks_file) {
                    hooksFiles.push(toml.hooks_file);
                }
            });
        }
        const [localExt, localOptions, localParams]: [
            LocalExt | undefined,
            ExtOptions,
            LocalParams,
        ] = await args.dpp.getExt(
            args.denops,
            options,
            "local",
        ) as [LocalExt | undefined, ExtOptions, LocalParams];
        if (localExt) {
            const action = localExt.actions.local;

            const localPlugins = await action.callback({
                denops: args.denops,
                context,
                options,
                protocols,
                extOptions: localOptions,
                extParams: localParams,
                actionParams: {
                    directory: "~/dotfiles/.config/nvim/lua/my_plugin",
                    options: {
                        merged: false,
                    },
                },
            });
            console.log(localPlugins);
            for (const plugin of localPlugins) {
                if (plugin.name in recordPlugins) {
                    recordPlugins[plugin.name] = Object.assign(
                        recordPlugins[plugin.name],
                        plugin,
                    );
                } else {
                    recordPlugins[plugin.name] = plugin;
                }
            }
        }
        // use lazy
        const lazyResult: LazyMakeStateResult | undefined = await args.dpp
            .extAction(
                args.denops,
                context,
                options,
                "lazy",
                "makeState",
                {
                    plugins: Object.values(recordPlugins),
                },
            ) as LazyMakeStateResult | undefined;
        return {
            plugins: lazyResult?.plugins ?? [],
            stateLines: lazyResult?.stateLines ?? [],
            checkFiles: tomlPaths,
            ftplugins: ftplugins,
        };
    }
}
