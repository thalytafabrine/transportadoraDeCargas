module transportadora

sig Pedido {

documentos: Documento

}

sig Documento {}

pred show[]{}
run show for 3
