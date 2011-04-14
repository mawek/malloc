// Place your Spring DSL code here
// lokalizacia: http://stackoverflow.com/questions/1569446/grails-how-to-change-the-current-locale
beans = {
	multipartResolverBean(org.springframework.web.multipart.commons.CommonsMultipartResolver){ 
		maxUploadSize=1000000 
	}
		
	localeResolver(org.springframework.web.servlet.i18n.SessionLocaleResolver) {
	   defaultLocale = new Locale("cs","CS")
	   java.util.Locale.setDefault(defaultLocale)
	}	
}
