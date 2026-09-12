import { GuildWars2EntityBase } from '../GuildWars2EntityBase';
import type { GuildWars2SDK } from '../GuildWars2SDK';
import type { Control } from '../types';
import type { GuildAuthenticated, GuildAuthenticatedListMatch } from '../GuildWars2Types';
declare class GuildAuthenticatedEntity extends GuildWars2EntityBase<GuildAuthenticated> {
    constructor(client: GuildWars2SDK, entopts: any);
    make(this: GuildAuthenticatedEntity): GuildAuthenticatedEntity;
    list(this: any, reqmatch?: GuildAuthenticatedListMatch, ctrl?: Control): Promise<GuildAuthenticatedEntity[]>;
}
export { GuildAuthenticatedEntity };
