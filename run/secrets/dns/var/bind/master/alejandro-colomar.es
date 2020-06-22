$TTL										604800
@		IN	SOA	dns.alejandro-colomar.es. root.dns.alejandro-colomar.es. (
										2
										604800
										86400
										2419200
										604800 )
		IN	NS	dns.alejandro-colomar.es.
dns		IN	A	127.0.0.1
kube-apiserver	IN	CNAME	dns

www		IN	A	10.168.10.100
www		IN	A	10.168.10.101
www		IN	A	10.168.10.102

gui0		IN	A	10.168.10.50
manager0	IN	A	10.168.10.100
worker0		IN	A	10.168.10.200

gui1		IN	A	10.168.10.51
manager1	IN	A	10.168.10.101
worker1		IN	A	10.168.10.201

gui2		IN	A	10.168.10.52
manager2	IN	A	10.168.10.102
worker2		IN	A	10.168.10.202
