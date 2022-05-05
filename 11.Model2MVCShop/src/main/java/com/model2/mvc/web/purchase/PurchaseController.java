
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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.product.ProductService;


//==> ���Ű��� Controller
@Controller
@RequestMapping("/purchase/*")
public class PurchaseController {
	
	///Field
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	//setter Method ���� ����
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	public PurchaseController(){
		System.out.println(this.getClass());
	}
	
	//==> classpath:config/common.properties  ,  classpath:config/commonservice.xml ���� �Ұ�
	//==> �Ʒ��� �ΰ��� �ּ��� Ǯ�� �ǹ̸� Ȯ�� �Ұ�
	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	
	//@RequestMapping("/addPurchaseView.do")
	//public String addPurchase( @RequestParam("prodNo") int prodNo , Model model) throws Exception {
	@RequestMapping( value="addPurchase", method=RequestMethod.GET )
	public String addPurchase(@RequestParam("prodNo") int prodNo , Model model) throws Exception {
		
		System.out.println("/purchase/addPurchase:GET");
		
		Product product = productService.getProduct(prodNo);
		
		model.addAttribute("product", product);
		
		return "forward:/purchase/addPurchaseView.jsp";
	}
	
	//@RequestMapping("/addPurchase.do")
	//public String addPurchaseView(@RequestParam("prodNo") int prodNo, @ModelAttribute("purchase") Purchase purchase, HttpSession session) throws Exception{
	@RequestMapping( value="addPurchase", method=RequestMethod.POST )
	public String addPurchase(@RequestParam("prodNo") int prodNo, @ModelAttribute("purchase") Purchase purchase, HttpSession session) throws Exception {
		
		System.out.println("/purchase/addPurchase:POST");
		
		User user = (User)session.getAttribute("user");
		System.out.println(user);
		Product product = new Product();
		product.setProdNo(prodNo);
		purchase.setPurchaseProd(product);
		purchase.setBuyer(user);
		
		
		purchaseService.addPurchase(purchase);
		
		return "forward:/purchase/addPurchase.jsp";
	}
	
	//@RequestMapping("/getPurchase.do")
	//public String getPurchase( @RequestParam("tranNo") int tranNo , Model model ) throws Exception {
	@RequestMapping( value="getPurchase", method=RequestMethod.GET )
	public String getPurchase( @RequestParam("tranNo") int tranNo , Model model ) throws Exception {
		
		System.out.println("/purchase/getPurchase:GET");
		//Business Logic
		Purchase purchase = purchaseService.getPurchase(tranNo);
		// Model �� View ����
		model.addAttribute("purchase", purchase);
		
		return "forward:/purchase/getPurchase.jsp";
	}
	
	//@RequestMapping("/updatePurchaseView.do")
	//public String updatePurchaseView( @RequestParam("tranNo") int tranNo , Model model ) throws Exception{
	@RequestMapping( value="updatePurchase", method=RequestMethod.GET )
	public String updatePurchase( @RequestParam("tranNo") int tranNo , Model model ) throws Exception{
		
		System.out.println("/purchase/updatePurchase:GET");
		//Business Logic
		Purchase purchase = purchaseService.getPurchase(tranNo);
		// Model �� View ����
		model.addAttribute("purchase", purchase);
		
		return "forward:/purchase/updatePurchase.jsp";
	}
	
	//@RequestMapping("/updatePurchase.do")
	//public String updatePurchase( @ModelAttribute("purchase") Purchase purchase , Model model , HttpSession session) throws Exception{
	@RequestMapping( value="updatePurchase", method=RequestMethod.POST )
	public String updatePurchase(@ModelAttribute("purchase") Purchase purchase , Model model , HttpSession session) throws Exception{
		System.out.println("/purchase/updatePurchase:POST");
		//Business Logic
		purchaseService.updatePurchase(purchase);
		
		return "redirect:/purchase/getPurchase?tranNo="+purchase.getTranNo();
	}
		
	//@RequestMapping("/updateTranCode.do")
	@RequestMapping( value="updateTranCode", method=RequestMethod.GET )
	public String updateTranCode(@ModelAttribute("purchase") Purchase purchase , @ModelAttribute("product") Product product , Model model , HttpSession session) throws Exception{
		
		System.out.println("/purchase/updatePurchase:GET");
		//Business Logic
		purchase.setPurchaseProd(product);
		purchaseService.updateTranCode(purchase);
		
		return "forward:/product/listProduct?menu=search";
	}
	
	
	//@RequestMapping("/listPurchase.do")
	//public String listPurchase( @ModelAttribute("search") Search search , Model model , HttpSession session) throws Exception{
	@RequestMapping( value="listPurchase" )
	public String listPurchase( @ModelAttribute("search") Search search , Model model , HttpSession session) throws Exception{
		
		System.out.println("/purchase/listPurchase:GET/POST");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		// Business logic ����
		Map<String , Object> map=purchaseService.getPurchaseList(search, (((User)session.getAttribute("user")).getUserId()));

		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		List<Purchase> list = (List)map.get("list");
		for (Purchase product : list) {
			System.out.println(product);
		}
		// Model �� View ����
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		return "forward:/purchase/listPurchase.jsp";
	}
}