import { GuildWars2EntityBase } from '../GuildWars2EntityBase';
import type { GuildWars2SDK } from '../GuildWars2SDK';
import type { Control } from '../types';
import type { DailyReward, DailyRewardListMatch } from '../GuildWars2Types';
declare class DailyRewardEntity extends GuildWars2EntityBase<DailyReward> {
    constructor(client: GuildWars2SDK, entopts: any);
    make(this: DailyRewardEntity): DailyRewardEntity;
    list(this: any, reqmatch?: DailyRewardListMatch, ctrl?: Control): Promise<DailyRewardEntity[]>;
}
export { DailyRewardEntity };
