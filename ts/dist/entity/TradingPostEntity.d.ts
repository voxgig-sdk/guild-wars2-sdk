import { GuildWars2EntityBase } from '../GuildWars2EntityBase';
import type { GuildWars2SDK } from '../GuildWars2SDK';
import type { Control } from '../types';
import type { TradingPost, TradingPostLoadMatch, TradingPostListMatch } from '../GuildWars2Types';
declare class TradingPostEntity extends GuildWars2EntityBase<TradingPost> {
    constructor(client: GuildWars2SDK, entopts: any);
    make(this: TradingPostEntity): TradingPostEntity;
    load(this: any, reqmatch?: TradingPostLoadMatch, ctrl?: Control): Promise<TradingPostEntity>;
    list(this: any, reqmatch?: TradingPostListMatch, ctrl?: Control): Promise<TradingPostEntity[]>;
}
export { TradingPostEntity };
