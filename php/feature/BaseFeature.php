<?php
declare(strict_types=1);

// GuildWars2 SDK base feature

class GuildWars2BaseFeature
{
    public string $version;
    public string $name;
    public bool $active;

    // Positions this feature when added via the client `extend` option:
    // "__before__" / "__after__" / "__replace__" name an already-added
    // feature (mirrors the ts feature `_options`). Declared so setting it
    // on an extension instance avoids the dynamic-property deprecation.
    public ?array $_options = null;

    public function __construct()
    {
        $this->version = '0.0.1';
        $this->name = 'base';
        $this->active = true;
    }

    public function get_version(): string { return $this->version; }
    public function get_name(): string { return $this->name; }
    public function get_active(): bool { return $this->active; }

    public function init(GuildWars2Context $ctx, array $options): void {}
    public function PostConstruct(GuildWars2Context $ctx): void {}
    public function PostConstructEntity(GuildWars2Context $ctx): void {}
    public function SetData(GuildWars2Context $ctx): void {}
    public function GetData(GuildWars2Context $ctx): void {}
    public function GetMatch(GuildWars2Context $ctx): void {}
    public function SetMatch(GuildWars2Context $ctx): void {}
    public function PrePoint(GuildWars2Context $ctx): void {}
    public function PreSpec(GuildWars2Context $ctx): void {}
    public function PreRequest(GuildWars2Context $ctx): void {}
    public function PreResponse(GuildWars2Context $ctx): void {}
    public function PreResult(GuildWars2Context $ctx): void {}
    public function PreDone(GuildWars2Context $ctx): void {}
    public function PreUnexpected(GuildWars2Context $ctx): void {}
}
