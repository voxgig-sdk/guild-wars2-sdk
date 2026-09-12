import { GuildWars2EntityBase } from '../GuildWars2EntityBase';
import type { GuildWars2SDK } from '../GuildWars2SDK';
import type { Control } from '../types';
import type { Achievement, AchievementLoadMatch, AchievementListMatch } from '../GuildWars2Types';
declare class AchievementEntity extends GuildWars2EntityBase<Achievement> {
    constructor(client: GuildWars2SDK, entopts: any);
    make(this: AchievementEntity): AchievementEntity;
    load(this: any, reqmatch?: AchievementLoadMatch, ctrl?: Control): Promise<AchievementEntity>;
    list(this: any, reqmatch?: AchievementListMatch, ctrl?: Control): Promise<AchievementEntity[]>;
}
export { AchievementEntity };
