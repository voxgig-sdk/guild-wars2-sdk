import { GuildWars2EntityBase } from '../GuildWars2EntityBase';
import type { GuildWars2SDK } from '../GuildWars2SDK';
import type { Control } from '../types';
import type { MapInformation, MapInformationListMatch } from '../GuildWars2Types';
declare class MapInformationEntity extends GuildWars2EntityBase<MapInformation> {
    constructor(client: GuildWars2SDK, entopts: any);
    make(this: MapInformationEntity): MapInformationEntity;
    list(this: any, reqmatch?: MapInformationListMatch, ctrl?: Control): Promise<MapInformationEntity[]>;
}
export { MapInformationEntity };
