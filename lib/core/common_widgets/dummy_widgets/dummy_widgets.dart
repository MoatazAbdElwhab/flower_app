import '../../../features/cart/presentation/widgets/cart_product/cart_product.dart';
import '../../../features/home/domain/entities/product_entity.dart';

class AppDummyWidgets {
  get dummyCartProductsList =>  [
        CartProductWidget(
            isDummy: true,
            productEntity: ProductEntity(
                id: 'id',
                title: 'title',
                imgCover: 'https://picsum.photos/id/237/200/300',
                price: 2354622,
                priceAfterDiscount: 2222222222222222,
                images: const [
                  'cc63221c-acd9-4eeb-a2b3-b9ff9c28e2ba-flower_image.png',
                  'cc63221c-acd9-4eeb-a2b3-b9ff9c28e2ba-flower_image.png'
                ],
                description:
                    'sdsds fsdsa asd ad asd ssd a asddasasd  asd asd asd asd sad asd asd asd asd  asd asd asd asdasd')),
        CartProductWidget(
            isDummy: true,
            productEntity: ProductEntity(
                id: 'id',
                title: 'title',
                imgCover:
                    'https://images.pexels.com/photos/213399/pexels-photo-213399.jpeg',
                price: 222,
                priceAfterDiscount: 2222,
                images: const [
                  'cc63221c-acd9-4eeb-a2b3-b9ff9c28e2ba-flower_image.png',
                  'cc63221c-acd9-4eeb-a2b3-b9ff9c28e2ba-flower_image.png'
                ],
                description: 'asd asdasd')),
        CartProductWidget(
            isDummy: true,
            productEntity: ProductEntity(
                id: 'id',
                title: 'title',
                imgCover: 'https://i.imgur.com/RRUe0Mo.png',
                price: 222,
                priceAfterDiscount: 2222,
                images: [
                  'cc63221c-acd9-4eeb-a2b3-b9ff9c28e2ba-flower_image.png',
                  'cc63221c-acd9-4eeb-a2b3-b9ff9c28e2ba-flower_image.png'
                ],
                description: 'asd asdasd')),
        CartProductWidget(
            isDummy: true,
            productEntity: ProductEntity(
                id: 'id',
                title: 'title',
                imgCover: 'https://i.imgur.com/RRUe0Mo.png',
                price: 222,
                priceAfterDiscount: 2222,
                images: const [
                  'cc63221c-acd9-4eeb-a2b3-b9ff9c28e2ba-flower_image.png',
                  'cc63221c-acd9-4eeb-a2b3-b9ff9c28e2ba-flower_image.png'
                ],
                description: 'asd asdasd'))
      ];
}
