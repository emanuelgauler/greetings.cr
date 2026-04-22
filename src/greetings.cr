require "./greetings/version"
require "option_parser"
parser = OptionParser.new do |p|
	 p.banner = "greetings [options]"

	 p.on("version", "Muestra la versión de la app") do
			puts VERSION; exit
	 end
	 
end
parser.parse

# guardar como app.cr
require "uing"

UIng.init do

	 window = UIng::Window.new("Saludo", width: 320, height: 140) do |w|
			w.on_closing { UIng.quit; true }

			# Etiqueta
			label = UIng::Label.new("Su nombre aquí")

			# Campo de texto
			input = UIng::Entry.new

			# Botón enviar
			button = UIng::Button.new("Enviar")
			button.on_clicked do
				 nombre = input.text || "mundo"
				 w.msg_box("Saludo", "Hola, #{nombre}!")
			end

			vbox = UIng::Box.new(:vertical, padded: true)
			vbox.append(label)
			vbox.append(input)
			vbox.append(button)
			w.child = vbox
			w.show
	 end
	 UIng.main
end

