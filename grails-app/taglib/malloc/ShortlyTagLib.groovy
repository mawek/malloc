package malloc

/*
 * Vypise skratenu verziu stringu parametru. Pouvisa sa napriklad ked sa vypisuje zoznam oddeleni a neni potrebne vypisat cely stlpec description alebo len par prvych znakov (kvoli formatovaniu)
 * */
class ShortlyTagLib {
	def shortly = { attrs, body ->
		def str = attrs['value']
		out << ((str.size() > 15)? "${str[0..14]}..." : str)
	}
}
