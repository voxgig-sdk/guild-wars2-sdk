import { GuildWars2EntityBase } from '../GuildWars2EntityBase';
import type { GuildWars2SDK } from '../GuildWars2SDK';
import type { Control } from '../types';
import type { Item, ItemListMatch } from '../GuildWars2Types';
declare class ItemEntity extends GuildWars2EntityBase<Item> {
    constructor(client: GuildWars2SDK, entopts: any);
    make(this: ItemEntity): ItemEntity;
    list(this: any, reqmatch?: ItemListMatch, ctrl?: Control): Promise<ItemEntity[]>;
}
export { ItemEntity };
