import { GuildWars2EntityBase } from '../GuildWars2EntityBase';
import type { GuildWars2SDK } from '../GuildWars2SDK';
import type { Control } from '../types';
import type { MapType, MapListMatch } from '../GuildWars2Types';
declare class MapEntity extends GuildWars2EntityBase<MapType> {
    constructor(client: GuildWars2SDK, entopts: any);
    make(this: MapEntity): MapEntity;
    list(this: any, reqmatch?: MapListMatch, ctrl?: Control): Promise<MapEntity[]>;
}
export { MapEntity };
