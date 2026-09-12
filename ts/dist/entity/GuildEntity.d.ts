import { GuildWars2EntityBase } from '../GuildWars2EntityBase';
import type { GuildWars2SDK } from '../GuildWars2SDK';
import type { Control } from '../types';
import type { Guild, GuildLoadMatch, GuildListMatch } from '../GuildWars2Types';
declare class GuildEntity extends GuildWars2EntityBase<Guild> {
    constructor(client: GuildWars2SDK, entopts: any);
    make(this: GuildEntity): GuildEntity;
    load(this: any, reqmatch?: GuildLoadMatch, ctrl?: Control): Promise<GuildEntity>;
    list(this: any, reqmatch?: GuildListMatch, ctrl?: Control): Promise<GuildEntity[]>;
}
export { GuildEntity };
