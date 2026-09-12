import { GuildWars2EntityBase } from '../GuildWars2EntityBase';
import type { GuildWars2SDK } from '../GuildWars2SDK';
import type { Control } from '../types';
import type { StructuredPvP, StructuredPvPListMatch } from '../GuildWars2Types';
declare class StructuredPvPEntity extends GuildWars2EntityBase<StructuredPvP> {
    constructor(client: GuildWars2SDK, entopts: any);
    make(this: StructuredPvPEntity): StructuredPvPEntity;
    list(this: any, reqmatch?: StructuredPvPListMatch, ctrl?: Control): Promise<StructuredPvPEntity[]>;
}
export { StructuredPvPEntity };
