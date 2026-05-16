package core

type GuildWars2Error struct {
	IsGuildWars2Error bool
	Sdk              string
	Code             string
	Msg              string
	Ctx              *Context
	Result           any
	Spec             any
}

func NewGuildWars2Error(code string, msg string, ctx *Context) *GuildWars2Error {
	return &GuildWars2Error{
		IsGuildWars2Error: true,
		Sdk:              "GuildWars2",
		Code:             code,
		Msg:              msg,
		Ctx:              ctx,
	}
}

func (e *GuildWars2Error) Error() string {
	return e.Msg
}
