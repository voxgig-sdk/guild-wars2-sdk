import { GuildWars2EntityBase } from '../GuildWars2EntityBase';
import type { GuildWars2SDK } from '../GuildWars2SDK';
import type { Control } from '../types';
import type { Authenticated, AuthenticatedLoadMatch, AuthenticatedListMatch } from '../GuildWars2Types';
declare class AuthenticatedEntity extends GuildWars2EntityBase<Authenticated> {
    constructor(client: GuildWars2SDK, entopts: any);
    make(this: AuthenticatedEntity): AuthenticatedEntity;
    load(this: any, reqmatch?: AuthenticatedLoadMatch, ctrl?: Control): Promise<AuthenticatedEntity>;
    list(this: any, reqmatch?: AuthenticatedListMatch, ctrl?: Control): Promise<AuthenticatedEntity[]>;
}
export { AuthenticatedEntity };
