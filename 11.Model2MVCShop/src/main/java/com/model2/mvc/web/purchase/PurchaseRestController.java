
package com.model2.mvc.web.purchase;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.product.ProductService;


//==> 备概包府 RestController
@RestController
@RequestMapping("/purchase/*")
public class PurchaseRestController {
	
	///Field
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	//setter Method 备泅 臼澜
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	public PurchaseRestController(){
		System.out.println(this.getClass());
	}
	

	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	
	@RequestMapping( value="json/addPurchase", method=RequestMethod.POST )
	public Purchase addPurchase(@RequestBody Purchase purchase, HttpSession session) throws Exception {
		
		System.out.println("/purchase/addPurchase:GET");
		
		purchaseService.addPurchase(purchase);
		
		return purchase;
	}
	
	
	@RequestMapping( value="json/getPurchase/{tranNo}", method=RequestMethod.GET )
	public Purchase getPurchase( @PathVariable int tranNo ) throws Exception{
		
		System.out.println("/purchase/json/getPurchase : GET");
		
		//Business Logic
		return purchaseService.getPurchase(tranNo);
	}
	
	@RequestMapping( value="json/updatePurchase", method=RequestMethod.POST )
	public Purchase updatePurchase(@RequestBody Purchase purchase, HttpSession session)throws Exception{

	System.out.println("/purchase/json/updatePurchase : POST");
	//Business Logic
	
	purchaseService.updatePurchase(purchase);
	
	return purchase;

	}
	
	@RequestMapping( value="json/updateTranCode", method=RequestMethod.POST )
	public Purchase updateTranCode(@RequestBody Purchase purchase, HttpSession session)throws Exception{

	System.out.println("/purchase/json/updateTranCode : POST");
	//Business Logic
	
	purchaseService.updateTranCode(purchase);
	
	return purchase;

	}

	
	
	@RequestMapping( value="json/getPurchaseList", method=RequestMethod.POST )
	public Map getPurchaseList(@RequestBody Search search, HttpServletRequest request, HttpSession session) throws Exception{
		
		System.out.println("/purchase/json/getPurchaseList : GET/POST");
				
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		

		Map<String , Object> map=purchaseService.getPurchaseList(search, (((User)session.getAttribute("user")).getUserId()));
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		map.put("list", map.get("list"));
		map.put("resultPage", resultPage);
		map.put("search", search);
		
		return map;
	}
}