module transportadora

--Criando uma central de transportadoras, que possuirá todas as transportadoras do Nordeste.
one sig CentralTransportadora {
	transportadoras: set Transportadora
}

--Assinatura de uma transportadora genérica, todas possuem um set de caminhão
abstract sig Transportadora {
	caminhoes: set Caminhao
}

-- Assinatura das transportadoras específicas de cada estado do Nordeste
one sig TransportadoraPB extends Transportadora {}
one sig	TransportadoraPE extends Transportadora {}
one sig TransportadoraRN extends Transportadora {}
one sig TransportadoraAL extends Transportadora {}
one sig TransportadoraSE extends Transportadora {}
one sig TransportadoraBA extends Transportadora {}
one sig TransportadoraCE extends Transportadora {}
one sig TransportadoraPI extends Transportadora {}
one sig TransportadoraMA extends Transportadora {}

--Criando caminhão(ões) para o transporte de pedidos
sig Caminhao {
	pedidos: set Pedido
}

--Criando pedidos que possuirão um documento e um status
sig Pedido{
--Pedido tem apenas um documento (frete)
	documento: one Documento,
	status: one Status
}

--Assinatura de um destino genérico
abstract sig Destino{
}

--Assinatura dos destinos específicos, que será cada estado do nordeste
one sig PB extends Destino {}
one sig PE extends Destino {}
one sig RN extends Destino {}
one sig AL extends Destino {}
one sig SE extends Destino {}
one sig BA extends Destino {}
one sig CE extends Destino {}
one sig PI extends Destino {}
one sig MA extends Destino {}

--Assinatura de um status genérico
abstract sig Status{
}

--Assinatura dos status específicos de cada pedido, que será ou EmRota ou Entregue
sig EmRota extends Status{}
sig Entregue extends Status{}

--Criando o documento que possuirá um destino
sig Documento {
	destino: one Destino
}

-- Funções Auxiliares

--Retorna o destino de um pedido
fun getDestinoDoPedido[p: Pedido] : Destino {
	p.documento.destino
}

--Retorna os pedidos de um caminhão
fun getPedidosDoCaminhao[c: Caminhao]: Pedido {
	c.pedidos
}

--Retorna os caminhoes de uma transportadora
fun getCaminhoes[t: Transportadora]: Caminhao {
	t.caminhoes
}

--Retorna o documento de um pedido
fun getDocumentoDoPedido[p: Pedido]: Documento{
	p.documento
}


fact Pedido {
	--Fazendo com que todos os pedidos estejam relacionados a um caminhao (não criar pedidos orfãos).
	all p:Pedido | one p.~pedidos
}

fact Status{
	--Fazendo com que todos os status estejam relacionados a um pedido (não criar status orfãos).
	all s:Status | one s.~status
}

fact Documento {
	--Fazendo com que todos os documentos estejam relacionados a um pedido (não criar documentos orfãos).
	all d:Documento | one d.~documento
}

fact Caminhao {
	--Fazendo com que todos os caminhões estejam relacionados a uma transportadora (não criar caminhões orfãos).
	all c:Caminhao | one c.~caminhoes
}

fact Transportadora {
	--Fazendo com que todas as transportadoras estejam relacionadas a central de transportadoras (não criar transportadoras orfãs, sem a central de transportadora).
	all t:Transportadora | one t.~transportadoras
}


fact Destino {
	--Fazendo com que todos os destinos estejam relacionados a um documento (não criar destinos orfãos).
	all d:Destino | one d.~destino
}

-- Predicados

--Predicado para verificar se o documento está vinculado ao seu respectivo pedido.
pred documentoEstaEmPedido[d: Documento, p: Pedido]{
		d in p.documento
}

--Predicado para verificar se o pedido tem um respectivo destino.
pred pedidoTemUmDestino[p: Pedido, d: Destino]{
	d in p.documento.destino
}

--Predicado para verificar se o pedido tem um status relacionado a ele.
pred pedidoTemUmStatus[p: Pedido, s: Status]{
	s in p.status
}

-- Asserções

--Testando se todos os pedidos tem um documento relacionado.
--Fazendo uso do predicado que verifica se o pedido tem um documento relacionado.
assert todosOsPedidosTemDocumento {all p: Pedido | one d: Documento | documentoEstaEmPedido[d, p]}

--Testando se todos os pedidos tem um destino relacionado.
--Fazendo uso do predicado que verifica se o pedido tem um destino relacionado.
assert todosOsPedidosTemUmDestino {all p: Pedido | one d: Destino | pedidoTemUmDestino[p,d]}

assert todosOsPedidosTemUmStatus {all p: Pedido | one s: Status | pedidoTemUmStatus[p,s]}

pred show[]{}
run show for 9
