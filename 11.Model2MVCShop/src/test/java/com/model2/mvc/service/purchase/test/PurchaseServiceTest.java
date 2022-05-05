package com.model2.mvc.service.purchase.test;

import java.util.List;
import java.util.Map;

import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.purchase.PurchaseService;



@RunWith(SpringJUnit4ClassRunner.class)
//@ContextConfiguration(locations = { "classpath:config/commonservice.xml" })
@ContextConfiguration	(locations = {	"classpath:config/context-common.xml",
										"classpath:config/context-aspect.xml",
										"classpath:config/context-mybatis.xml",
										"classpath:config/context-transaction.xml" })
public class PurchaseServiceTest {

   //==>@RunWith,@ContextConfiguration �̿� Wiring, Test �� instance DI
   @Autowired
   @Qualifier("purchaseServiceImpl")
   private PurchaseService purchaseService;

   //@Test
   public void testAddPurchase() throws Exception {
      
      Product product = new Product();
      product.setProdNo(10125);
      
      User user = new User();
      user.setUserId("user23");
      
      Purchase purchase = new Purchase();
      purchase.setPurchaseProd(product);
      purchase.setBuyer(user);
      purchase.setPaymentOption("1");
      purchase.setReceiverName("���ڸ�");
      purchase.setReceiverPhone("010-1111-1111");
      purchase.setDivyAddr("����");
      purchase.setDivyRequest("����");
      purchase.setDivyDate("2022-04-18");
      
      purchaseService.addPurchase(purchase);
      

      //==> console Ȯ��
      System.out.println(purchase);
      
      //==> API Ȯ��
      Assert.assertEquals(10125, purchase.getPurchaseProd().getProdNo());
      Assert.assertEquals("user23", purchase.getBuyer().getUserId());
      Assert.assertEquals("1", purchase.getPaymentOption().trim());
      Assert.assertEquals("���ڸ�", purchase.getReceiverName());
      Assert.assertEquals("010-1111-1111", purchase.getReceiverPhone());
      Assert.assertEquals("����", purchase.getDivyAddr());
      Assert.assertEquals("����", purchase.getDivyRequest());
      Assert.assertEquals("2022-04-18", purchase.getDivyDate());

   }

   //@Test
   public void testGetPurchase() throws Exception {
      
      Purchase purchase = new Purchase();
      
      purchase = purchaseService.getPurchase(10086);

      //==> console Ȯ��
      System.out.println(purchase);
      
      //==> API Ȯ��
      Assert.assertEquals(10086, purchase.getTranNo());
      Assert.assertEquals(10036, purchase.getPurchaseProd().getProdNo());
      Assert.assertEquals("user23", purchase.getBuyer().getUserId());
      Assert.assertEquals("2", purchase.getPaymentOption().trim());
      Assert.assertEquals("���ڸ�", purchase.getReceiverName());
      Assert.assertEquals("010-1111-1111", purchase.getReceiverPhone());
      Assert.assertEquals("����", purchase.getDivyAddr());
      Assert.assertEquals("����", purchase.getDivyRequest());
      Assert.assertEquals("2022-04-18 00:00:00", purchase.getDivyDate());

   }
   
   //@Test
    public void testUpdatePurchase() throws Exception{
       
      Purchase purchase = purchaseService.getPurchase(10086);
      Assert.assertNotNull(purchase);
           

      purchase.setPaymentOption("2");
      purchase.setReceiverName("������");
      purchase.setReceiverPhone("010-2222-2222");
      purchase.setDivyAddr("����Ư����");
      purchase.setDivyRequest("����� ����");
      purchase.setDivyDate("2022-04-20");
      
      purchaseService.updatePurchase(purchase);
      
      purchase = purchaseService.getPurchase(10086);
      Assert.assertNotNull(purchase);
      
      //==> console Ȯ��
      System.out.println(purchase);
         
      //==> API Ȯ��
      Assert.assertEquals(10086, purchase.getTranNo());
      Assert.assertEquals(10036, purchase.getPurchaseProd().getProdNo());
      Assert.assertEquals("user23", purchase.getBuyer().getUserId());
      Assert.assertEquals("2", purchase.getPaymentOption().trim());
      Assert.assertEquals("������", purchase.getReceiverName());
      Assert.assertEquals("010-2222-2222", purchase.getReceiverPhone());
      Assert.assertEquals("����Ư����", purchase.getDivyAddr());
      Assert.assertEquals("����� ����", purchase.getDivyRequest());
      Assert.assertEquals("2022-04-20 00:00:00", purchase.getDivyDate());
    }
    
    //@Test
    public void testUpdateTranCode() throws Exception{
        
        Purchase purchase = purchaseService.getPurchase(10086);
        Assert.assertNotNull(purchase);
             

        purchase.setTranCode("2");
        
        purchaseService.updateTranCode(purchase);
        
        purchase = purchaseService.getPurchase(10086);
        Assert.assertNotNull(purchase);
        
        //==> console Ȯ��
        System.out.println(purchase);
           
        //==> API Ȯ��
        Assert.assertEquals(2, purchase.getTranCode().trim());

      }
    
    
    
    //@Test
    public void testGetPurchaseListAll() throws Exception{
       
       Search search = new Search();
       search.setCurrentPage(1);
       search.setPageSize(3);
       Map<String,Object> map = purchaseService.getPurchaseList(search,"user23");
       
       List<Object> list = (List<Object>)map.get("list");
       Assert.assertEquals(3, list.size());
       
      //==> console Ȯ��
       System.out.println(list);
       
       Integer totalCount = (Integer)map.get("totalCount");
       System.out.println(totalCount);
       
       System.out.println("=======================================");
       
    }
    
    
    
    
    
}
   

   