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
www		IN	A	10.168.6.100

gui0		IN	A	10.168.10.50
manager0	IN	A	10.168.10.100
worker0		IN	A	10.168.10.200

gui1		IN	A	10.168.11.50
manager1	IN	A	10.168.11.100
worker1		IN	A	10.168.11.200

gui2		IN	A	10.168.12.50
manager2	IN	A	10.168.12.100
worker2		IN	A	10.168.12.200
