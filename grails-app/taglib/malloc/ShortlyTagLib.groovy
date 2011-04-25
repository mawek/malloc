package malloc

/*
 * Vypise skratenu verziu stringu parametru. Pouziva sa napriklad ked sa vypisuje zoznam oddeleni a neni potrebne vypisat cely stlpec description alebo len par prvych znakov (kvoli formatovaniu)
 * */
class ShortlyTagLib {
	def shortly = { attrs, body ->
		def str = attrs['value']
		def length = (attrs['length'] ? attrs['length'] : 12)
		out << ((str?.size() > length)? "${str[0..(length-1)]}..." : str)
	}
}
