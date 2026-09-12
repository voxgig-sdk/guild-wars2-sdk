import { Context } from './Context';
declare class GuildWars2Error extends Error {
    isGuildWars2Error: boolean;
    sdk: string;
    code: string;
    ctx: Context;
    status: number;
    get notFound(): boolean;
    constructor(code: string, msg: string, ctx: Context);
}
export { GuildWars2Error };
