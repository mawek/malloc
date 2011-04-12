dataSource {
	pooled = true
	driverClassName = "org.hsqldb.jdbcDriver"
	username = "sa"
	password = ""
}
hibernate {
	cache.use_second_level_cache = true
	cache.use_query_cache = true
	cache.provider_class = 'net.sf.ehcache.hibernate.EhCacheProvider'
}
// environment specific settings
environments {
	development{
		dataSource {
			driverClassName = "com.mysql.jdbc.Driver"
			dbCreate = "update" // one of 'create', 'create-drop','update'
			username = "mallocUsr"
			password = "mallocPsswd"
			url = "jdbc:mysql://localhost:3306/malloc"
		}
	}/*
	development {
		dataSource {			
			dbCreate = "create-drop" // one of 'create', 'create-drop','update'			
			url = "jdbc:hsqldb:mem:develDb"
		}
	}*/
	
	test {
		dataSource {
			dbCreate = "create-drop"
			url = "jdbc:hsqldb:mem:testDb"
		}
	}
	production {
		dataSource {
			driverClassName = "com.mysql.jdbc.Driver"
			dbCreate = "update" // one of 'create', 'create-drop','update'
			username = "mallocUsr"
			password = "mallocPsswd"
			url = "jdbc:mysql://localhost:3306/malloc"			
		}
	}
}
