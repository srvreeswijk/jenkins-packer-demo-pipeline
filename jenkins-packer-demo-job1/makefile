.PHONY: ssh-instance graph-svg graph-jpg

ssh-instance:
	ssh -i mykey centos@$$(terraform output ip)

graph-svg:
	terraform graph | dot -Tsvg > graph.svg

graph-jpg:
	terraform graph | dot -Tjpg > graph.jpg