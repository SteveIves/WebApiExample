<CODEGEN_FILENAME>UnityResolver.dbl</CODEGEN_FILENAME>

import System
import System.Collections.Generic
import System.Web.Http.Dependencies
import Microsoft.Practices.Unity

namespace <NAMESPACE>

	;;; <summary>
	;;; Implements a Unity IoC dependency resolver
	;;; </summary>
	public class UnityResolver implements IDependencyResolver

		protected _container, @IUnityContainer

		;;; <summary>
		;;; 
		;;; </summary>
		;;; <param name="container"></param>
		public method UnityResolver
			container, @IUnityContainer 
		proc
			if (container == ^null)
				throw new ArgumentNullException("container")
			_container = container
		endmethod

		;;; <summary>
		;;; 
		;;; </summary>
		;;; <param name="serviceType"></param>
		;;; <returns></returns>
		public method GetService, @object
			serviceType, @Type 
		proc
			try
			begin
				mreturn _container.Resolve(serviceType)
			end
			catch (syn_exception, @ResolutionFailedException)
			begin
				mreturn ^null
			end
			endtry
		endmethod

		;;; <summary>
		;;; 
		;;; </summary>
		;;; <param name="serviceType"></param>
		;;; <returns></returns>
		public method GetServices, @IEnumerable<object>
			serviceType, @Type 
		proc
			try
			begin
				mreturn _container.ResolveAll(serviceType)
			end
			catch (syn_exception, @ResolutionFailedException)
			begin
				mreturn new List<object>()
			end
			endtry
		endmethod

		;;; <summary>
		;;; 
		;;; </summary>
		;;; <returns></returns>
		public method BeginScope, @IDependencyScope
			endparams
		proc
			data child = _container.CreateChildContainer()
			mreturn new UnityResolver(child)
		endmethod

		;;; <summary>
		;;; IDisposable support
		;;; </summary>
		public method Dispose, void
			endparams
		proc
			_container.Dispose()
		endmethod

	endclass

endnamespace