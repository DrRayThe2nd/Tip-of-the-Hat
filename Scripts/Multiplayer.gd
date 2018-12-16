extends Node

const SERVER_IP = "localhost"
const SERVER_PORT = 8483

onready var server = PacketPeerUDP.new()

func _ready():
	server.set_dest_address(SERVER_IP, SERVER_PORT)
	server.listen(SERVER_PORT)

func quit():
	server.close()

func get_data():
	return server.get_var()

func send_data(purpose, data):
	server.put_var([purpose, data])