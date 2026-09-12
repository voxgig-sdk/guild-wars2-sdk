import { GuildWars2EntityBase } from '../GuildWars2EntityBase';
import type { GuildWars2SDK } from '../GuildWars2SDK';
import type { Control } from '../types';
import type { HomeInstance, HomeInstanceListMatch } from '../GuildWars2Types';
declare class HomeInstanceEntity extends GuildWars2EntityBase<HomeInstance> {
    constructor(client: GuildWars2SDK, entopts: any);
    make(this: HomeInstanceEntity): HomeInstanceEntity;
    list(this: any, reqmatch?: HomeInstanceListMatch, ctrl?: Control): Promise<HomeInstanceEntity[]>;
}
export { HomeInstanceEntity };
