module transportadora

sig Pedido {

documentos: set Documento

}

fact {
	all d:Documento | one d.~documentos
}

sig Documento {}

pred show[]{}
run show for 3
