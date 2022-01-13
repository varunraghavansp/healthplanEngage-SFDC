/**
 * Created by varun on 1/5/2021.
 */

@IsTest
private class IHA_ShoppingCartControllerTest {
    @IsTest(SeeAllData=true)
    static void getAllShoppingDetails_TestPositive() {
        IHA_ShoppingCartController.IHAShoppingCartInfoWrapper cartInfoWrapper =  IHA_ShoppingCartController.getAllShoppingDetails();
        System.debug(cartInfoWrapper);
    }
}