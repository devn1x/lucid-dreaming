extends VBoxContainer

const Tool = preload("res://scripts/ui/level/Tool.gd")

@export_category("Toolbox")
@export var tools: Array[Tool] = []

var current_tool: Tool

func _ready():
	for tool in tools:
		var tool_node: Button = $ToolTemplate.duplicate();
		tool.node = tool_node
		tool_node.visible = true
		tool_node.tooltip_text = tool.display_name
		tool_node.icon = tool.icon_button
		tool_node.toggled.connect(_on_tool_pressed.bind(tool))
		self.add_child(tool_node);

func _on_tool_pressed(toggled, tool):
	if toggled and current_tool == tool:
		tool.node.button_pressed = false
		tool = null
	
	if current_tool != tool:
		change_tool(tool)

func change_tool(tool):
	if tool != null:
		Input.set_custom_mouse_cursor(tool.icon_cursor)
	else:
		Input.set_custom_mouse_cursor(null)
	current_tool = tool
