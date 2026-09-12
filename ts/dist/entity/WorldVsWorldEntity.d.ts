import { GuildWars2EntityBase } from '../GuildWars2EntityBase';
import type { GuildWars2SDK } from '../GuildWars2SDK';
import type { Control } from '../types';
import type { WorldVsWorld, WorldVsWorldListMatch } from '../GuildWars2Types';
declare class WorldVsWorldEntity extends GuildWars2EntityBase<WorldVsWorld> {
    constructor(client: GuildWars2SDK, entopts: any);
    make(this: WorldVsWorldEntity): WorldVsWorldEntity;
    list(this: any, reqmatch?: WorldVsWorldListMatch, ctrl?: Control): Promise<WorldVsWorldEntity[]>;
}
export { WorldVsWorldEntity };
