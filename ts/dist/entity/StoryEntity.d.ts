import { GuildWars2EntityBase } from '../GuildWars2EntityBase';
import type { GuildWars2SDK } from '../GuildWars2SDK';
import type { Control } from '../types';
import type { Story, StoryListMatch } from '../GuildWars2Types';
declare class StoryEntity extends GuildWars2EntityBase<Story> {
    constructor(client: GuildWars2SDK, entopts: any);
    make(this: StoryEntity): StoryEntity;
    list(this: any, reqmatch?: StoryListMatch, ctrl?: Control): Promise<StoryEntity[]>;
}
export { StoryEntity };
