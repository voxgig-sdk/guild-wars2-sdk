import { GuildWars2EntityBase } from '../GuildWars2EntityBase';
import type { GuildWars2SDK } from '../GuildWars2SDK';
import type { Control } from '../types';
import type { Miscellaneous, MiscellaneousLoadMatch, MiscellaneousListMatch } from '../GuildWars2Types';
declare class MiscellaneousEntity extends GuildWars2EntityBase<Miscellaneous> {
    constructor(client: GuildWars2SDK, entopts: any);
    make(this: MiscellaneousEntity): MiscellaneousEntity;
    load(this: any, reqmatch?: MiscellaneousLoadMatch, ctrl?: Control): Promise<MiscellaneousEntity>;
    list(this: any, reqmatch?: MiscellaneousListMatch, ctrl?: Control): Promise<MiscellaneousEntity[]>;
}
export { MiscellaneousEntity };
