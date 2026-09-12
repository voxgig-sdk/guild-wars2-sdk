import { GuildWars2EntityBase } from '../GuildWars2EntityBase';
import type { GuildWars2SDK } from '../GuildWars2SDK';
import type { Control } from '../types';
import type { GameMechanic, GameMechanicListMatch } from '../GuildWars2Types';
declare class GameMechanicEntity extends GuildWars2EntityBase<GameMechanic> {
    constructor(client: GuildWars2SDK, entopts: any);
    make(this: GameMechanicEntity): GameMechanicEntity;
    list(this: any, reqmatch?: GameMechanicListMatch, ctrl?: Control): Promise<GameMechanicEntity[]>;
}
export { GameMechanicEntity };
