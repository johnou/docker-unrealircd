import socket
import sys

sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

try:
    sock.bind(('', 6667))
except socket.error as err:
    print('Bind failed. Error code: ' + str(err.errno) + ', message: ' + str(err.strerror))
    sys.exit()

sock.listen(10)

while True:
    conn, addr = sock.accept()
    print('Connected with ' + addr[0] + ':' + str(addr[1]))
    conn.send(b':irc.hellface.com NOTICE * :*** Please reconnect on port 6697 with SSL enabled.\n')
    conn.close()

sock.close()
