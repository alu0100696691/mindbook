class Nota
	include DataMapper::Resource

	property :id, Serial, :key => true
	property :titulo, String
	property :descripcion, Text
	property :notaTexto, Text

	belongs_to :usuario

end

class Usuario
	include DataMapper::Resource

	property :id, Serial, :key => true
	property :email, Text
	property :login, Text
	property :nombre, Text
	property :password, Text

	has n, :notas, :constraint => :destroy
	
end



