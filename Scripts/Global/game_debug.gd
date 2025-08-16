extends Node

var show_exit_property : bool = false

func set_show_exit_property(boole):
	print("In game debug: " , get_show_exit_property())
	show_exit_property = boole
	
func get_show_exit_property() -> bool:
	return show_exit_property
	
