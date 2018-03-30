#!/usr/bin/env python
import asyncio
import websockets
import json
from random import random
import time



async def hello():
	async with websockets.connect('ws://localhost:4000/sensor_stream/websocket') as websocket:
		data = dict(topic="sensor_broadcast:all", event="phx_join", payload={}, ref=None)
		await websocket.send(json.dumps(data))
		# print("joined")
		#greeting = await websocket.recv()
		print("Joined")
		while True:
			msg = dict(topic='sensor_broadcast:all', event="sensor_value", payload={"id":3,"value":random()*100}, ref=None)
			await websocket.send(json.dumps(msg))
			#call = await websocket.recv()
			#print("< {}".format(call))
			time.sleep(0.2)



asyncio.get_event_loop().run_until_complete(hello())
asyncio.get_event_loop().run_forever()
