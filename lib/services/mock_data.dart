import '../models/product.dart';
import '../models/coupon.dart';

class MockData {
  static List<Product> get allProducts => [
        // ══════════ MUSLIM PRODUCTS ══════════
        Product(
          id: 'm1',
          name: 'Embroidered Abaya',
          description:
              'Elegant black abaya with intricate gold embroidery on cuffs and hem. Premium chiffon fabric, modest and graceful.',
          price: 2499,
          originalPrice: 3499,
          rating: 4.8,
          reviewCount: 312,
          images: [
            'https://images.unsplash.com/photo-1595433562696-9fb6d5f4f2e9?w=800&auto=format&fit=crop',
            'https://images.unsplash.com/photo-1580820267682-426da823b514?w=800&auto=format&fit=crop',
          ],
          community: 'Muslim',
          category: 'Modest Wear',
          sizes: ['XS', 'S', 'M', 'L', 'XL', 'XXL'],
          colors: ['#000000', '#1a1a2e', '#2d4a3e'],
          isVerified: true,
          hasTryOn: true,
          sellerName: 'Al-Noor Collections',
        ),
        Product(
          id: 'm2',
          name: 'Premium Silk Hijab',
          description:
              'Lightweight silk hijab with a smooth finish. Available in a range of rich, jewel-toned colors. Easy to drape and style.',
          price: 899,
          originalPrice: 1299,
          rating: 4.7,
          reviewCount: 540,
          images: [
            'https://images.unsplash.com/photo-1520975919076-5a0e2a6d9b1a?w=800&auto=format&fit=crop',
          ],
          community: 'Muslim',
          category: 'Accessories',
          sizes: ['One Size'],
          colors: ['#8B0000', '#000080', '#2d4a3e', '#4a0e4e'],
          isVerified: true,
          hasTryOn: true,
          sellerName: 'Hijab Luxe',
        ),
        Product(
          id: 'm3',
          name: 'Crystal Tasbeeh',
          description:
              'Hand-crafted 99-bead prayer beads with Swarovski crystals and a sterling silver tassel. A spiritual companion.',
          price: 1299,
          originalPrice: 1799,
          rating: 4.9,
          reviewCount: 220,
          images: [
            'https://images.unsplash.com/photo-1584551246679-0daf3d275d0f?w=400',
          ],
          community: 'Muslim',
          category: 'Prayer Items',
          sizes: ['Standard'],
          colors: ['#C9A84C', '#FFFFFF', '#8B0000'],
          isVerified: true,
          hasTryOn: false,
          sellerName: 'Barakah Store',
        ),
        Product(
          id: 'm4',
          name: 'Men\'s Kandura',
          description:
              'Premium white kandura crafted from Egyptian cotton. Perfectly tailored for comfort and elegance during prayers and occasions.',
          price: 3199,
          originalPrice: 4299,
          rating: 4.6,
          reviewCount: 188,
          images: [
            'https://images.unsplash.com/photo-1541099649105-f69ad21f3246?w=800&auto=format&fit=crop',
          ],
          community: 'Muslim',
          category: 'Men\'s Wear',
          sizes: ['S', 'M', 'L', 'XL', 'XXL'],
          colors: ['#FFFFFF', '#F5F5DC', '#C8C8C8'],
          isVerified: true,
          hasTryOn: true,
          sellerName: 'Al-Noor Collections',
        ),
        Product(
          id: 'm5',
          name: 'Oud Perfume Oil',
          description:
              'Pure oud oil sourced from the finest Assam trees. Rich, warm, and long-lasting. A signature scent for special occasions.',
          price: 4999,
          originalPrice: 6999,
          rating: 4.9,
          reviewCount: 95,
          images: [
            'https://images.unsplash.com/photo-1541480601022-2308c0f02487?w=400',
          ],
          community: 'Muslim',
          category: 'Fragrance',
          sizes: ['3ml', '6ml', '12ml'],
          colors: ['#8B4513'],
          isVerified: true,
          hasTryOn: false,
          sellerName: 'Oud Palace',
        ),
        Product(
          id: 'm6',
          name: 'Girls Modest Dress',
          description:
              'Beautiful cotton modest dress with flutter sleeves for girls. Perfect for daily wear, school, or special occasions.',
          price: 1599,
          originalPrice: 2299,
          rating: 4.6,
          reviewCount: 278,
          images: [
            'https://images.unsplash.com/photo-1564505267537-b85cab00c77b?w=400',
          ],
          community: 'Muslim',
          category: 'Modest Wear',
          sizes: ['2-3Y', '4-5Y', '6-7Y', '8-9Y', '10-11Y'],
          colors: ['#8B0000', '#000080', '#FF8C00'],
          isVerified: true,
          hasTryOn: true,
          sellerName: 'Al-Noor Collections',
        ),
        Product(
          id: 'm7',
          name: 'Prayer Mat with Compass',
          description:
              'Portable prayer mat with integrated compass. Lightweight, waterproof, and comes with a carrying bag. Perfect for travel.',
          price: 799,
          originalPrice: 1099,
          rating: 4.8,
          reviewCount: 412,
          images: [
            'https://images.unsplash.com/photo-1578749556568-bc2c40e68b61?w=400',
          ],
          community: 'Muslim',
          category: 'Prayer Items',
          sizes: ['Standard'],
          colors: ['#006400', '#8B0000', '#1a4a6e'],
          isVerified: true,
          hasTryOn: false,
          sellerName: 'Barakah Store',
        ),
        Product(
          id: 'm8',
          name: 'Rose Water Attar',
          description:
              'Premium rose water attar with natural ingredients. Perfect for daily use or special occasions. Lasts all day.',
          price: 2499,
          originalPrice: 3499,
          rating: 4.7,
          reviewCount: 189,
          images: [
            'https://images.unsplash.com/photo-1535632066927-ab7c9ab60908?w=400',
          ],
          community: 'Muslim',
          category: 'Fragrance',
          sizes: ['10ml', '15ml', '20ml'],
          colors: ['#8B4513'],
          isVerified: true,
          hasTryOn: false,
          sellerName: 'Oud Palace',
        ),
        // ══════════ HINDU PRODUCTS ══════════
        Product(
          id: 'h1',
          name: 'Banarasi Silk Saree',
          description:
              'Authentic Banarasi silk saree with real zari work. Passed through generations of Varanasi weavers. Perfect for weddings and festivals.',
          price: 8999,
          originalPrice: 12999,
          rating: 4.9,
          reviewCount: 445,
          images: [
            'https://images.unsplash.com/photo-1585386959984-a4155222c5f0?w=800&auto=format&fit=crop',
          ],
          community: 'Hindu',
          category: 'Sarees',
          sizes: ['Free Size (6m)'],
          colors: ['#8B0000', '#FF8C00', '#006400'],
          isVerified: true,
          hasTryOn: true,
          sellerName: 'Varanasi Heritage Weavers',
        ),
        Product(
          id: 'h2',
          name: 'Designer Anarkali Kurta',
          description:
              'Flared anarkali kurta in georgette fabric with mirror work. Comes with matching dupatta and churidar.',
          price: 3499,
          originalPrice: 5499,
          rating: 4.7,
          reviewCount: 320,
          images: [
            'https://images.unsplash.com/photo-1562158070-3b2a9f0b5cbd?w=800&auto=format&fit=crop',
          ],
          community: 'Hindu',
          category: 'Kurtas',
          sizes: ['XS', 'S', 'M', 'L', 'XL'],
          colors: ['#FF8C00', '#8B0000', '#4B0082'],
          isVerified: true,
          hasTryOn: true,
          sellerName: 'Rang Utsav',
        ),
        Product(
          id: 'h3',
          name: 'Puja Thali Set',
          description:
              'Handcrafted brass puja thali set with diya, bell, incense holder, and kumkum bowl. Engraved with Om symbol.',
          price: 1899,
          originalPrice: 2799,
          rating: 4.8,
          reviewCount: 560,
          images: [
            'https://images.unsplash.com/photo-1601127087940-59e81a3af78f?w=400',
          ],
          community: 'Hindu',
          category: 'Puja Items',
          sizes: ['Standard'],
          colors: ['#C9A84C', '#B87333'],
          isVerified: true,
          hasTryOn: false,
          sellerName: 'Devpuja Crafts',
        ),
        Product(
          id: 'h4',
          name: 'Men\'s Dhoti Kurta Set',
          description:
              'Premium cotton dhoti kurta set in ivory with golden border. Ideal for pujas, weddings, and festivals.',
          price: 2799,
          originalPrice: 3999,
          rating: 4.5,
          reviewCount: 210,
          images: [
            'https://images.unsplash.com/photo-1583500178690-594c236b6b60?w=400',
          ],
          community: 'Hindu',
          category: 'Men\'s Wear',
          sizes: ['S', 'M', 'L', 'XL', 'XXL'],
          colors: ['#FFFFF0', '#FFDAB9', '#F5DEB3'],
          isVerified: true,
          hasTryOn: true,
          sellerName: 'Rang Utsav',
        ),
        Product(
          id: 'h5',
          name: 'Mangalsutra with Pearls',
          description:
              'Traditional mangalsutra with precious pearls and gold-plated chain. A timeless symbol of marital bliss.',
          price: 4999,
          originalPrice: 6999,
          rating: 4.9,
          reviewCount: 523,
          images: [
            'https://images.unsplash.com/photo-1599643478518-a784e5dc4c8f?w=400',
          ],
          community: 'Hindu',
          category: 'Jewellery',
          sizes: ['One Size'],
          colors: ['#C9A84C', '#000000'],
          isVerified: true,
          hasTryOn: false,
          sellerName: 'Rang Utsav',
        ),
        Product(
          id: 'h6',
          name: 'Silk Lehenga Choli',
          description:
              'Beautiful silk lehenga choli set with intricate embroidery. Perfect for festivals, weddings, and celebrations.',
          price: 6499,
          originalPrice: 9999,
          rating: 4.8,
          reviewCount: 356,
          images: [
            'https://images.unsplash.com/photo-1617638924702-92f37f4f4267?w=400',
          ],
          community: 'Hindu',
          category: 'Kurtas',
          sizes: ['XS', 'S', 'M', 'L', 'XL'],
          colors: ['#8B0000', '#FF8C00', '#4B0082'],
          isVerified: true,
          hasTryOn: true,
          sellerName: 'Rang Utsav',
        ),
        Product(
          id: 'h7',
          name: 'Kumkum Holder & Tilak Kit',
          description:
              'Beautiful brass kumkum holder with traditional tilak application kit. Includes brushes and premium kumkum.',
          price: 999,
          originalPrice: 1499,
          rating: 4.7,
          reviewCount: 234,
          images: [
            'https://images.unsplash.com/photo-1599643478518-a784e5dc4c8f?w=400',
          ],
          community: 'Hindu',
          category: 'Puja Items',
          sizes: ['Standard'],
          colors: ['#C9A84C', '#8B0000'],
          isVerified: true,
          hasTryOn: false,
          sellerName: 'Devpuja Crafts',
        ),
        // ══════════ SIKH PRODUCTS ══════════
        Product(
          id: 's1',
          name: 'Premium Cotton Turban',
          description:
              'Hand-stitched pure cotton turban fabric in vibrant colours. 8 metres, ideal for Sikh dastar. Comfortable and long-lasting.',
          price: 1299,
          originalPrice: 1799,
          rating: 4.8,
          reviewCount: 275,
          images: [
            'https://images.unsplash.com/photo-1619033490422-4f90c7abb6b0?w=400',
          ],
          community: 'Sikh',
          category: 'Turban',
          sizes: ['5m', '6m', '7m', '8m'],
          colors: ['#006400', '#000080', '#8B0000', '#FF8C00', '#FFFFFF'],
          isVerified: true,
          hasTryOn: false,
          sellerName: 'Punjab Heritage',
        ),
        Product(
          id: 's2',
          name: 'Steel Kada',
          description:
              'Authentic stainless steel kara — one of the Five Ks of Sikhism. Smooth finish, available in different widths.',
          price: 599,
          originalPrice: 899,
          rating: 4.9,
          reviewCount: 620,
          images: [
            'https://images.unsplash.com/photo-1611591437281-460bfbe1220a?w=400',
          ],
          community: 'Sikh',
          category: 'Kara',
          sizes: ['Small', 'Medium', 'Large'],
          colors: ['#C0C0C0', '#C9A84C'],
          isVerified: true,
          hasTryOn: false,
          sellerName: 'Amritsar Crafts',
        ),
        Product(
          id: 's3',
          name: 'Punjabi Phulkari Dupatta',
          description:
              'Hand-embroidered Phulkari dupatta on georgette base. A traditional Punjabi art form with vibrant floral patterns.',
          price: 2499,
          originalPrice: 3499,
          rating: 4.7,
          reviewCount: 189,
          images: [
            'https://images.unsplash.com/photo-1596993100471-c3905dafa78e?w=400',
          ],
          community: 'Sikh',
          category: 'Accessories',
          sizes: ['Free Size'],
          colors: ['#FF8C00', '#8B0000', '#006400'],
          isVerified: true,
          hasTryOn: true,
          sellerName: 'Punjab Heritage',
        ),
        Product(
          id: 's4',
          name: 'Rumala Sahib Premium Silk',
          description:
              'Premium silk Rumala Sahib for granthi use or home gurudwara. Hand-woven with intricate patterns.',
          price: 3999,
          originalPrice: 5999,
          rating: 4.8,
          reviewCount: 167,
          images: [
            'https://images.unsplash.com/photo-1586695276895-cd378a70794e?w=400',
          ],
          community: 'Sikh',
          category: 'Accessories',
          sizes: ['Free Size'],
          colors: ['#FF8C00', '#8B0000', '#FFD700'],
          isVerified: true,
          hasTryOn: false,
          sellerName: 'Punjab Heritage',
        ),
        Product(
          id: 's5',
          name: 'Women\'s Salwar Kameez',
          description:
              'Traditional Punjabi salwar kameez in cotton. Straight cut with minimal embroidery, perfect for everyday wear.',
          price: 2199,
          originalPrice: 3299,
          rating: 4.6,
          reviewCount: 298,
          images: [
            'https://images.unsplash.com/photo-1584542604556-f03835f5e10b?w=400',
          ],
          community: 'Sikh',
          category: 'Kurtas',
          sizes: ['XS', 'S', 'M', 'L', 'XL'],
          colors: ['#FFFFFF', '#FFD700', '#FF6347'],
          isVerified: true,
          hasTryOn: true,
          sellerName: 'Punjab Heritage',
        ),
        // ══════════ CHRISTIAN PRODUCTS ══════════
        Product(
          id: 'c1',
          name: 'Lace Church Dress',
          description:
              'Elegant lace overlay midi dress suitable for Sunday service, baptisms, and weddings. Modest neckline and long sleeves.',
          price: 3299,
          originalPrice: 4999,
          rating: 4.6,
          reviewCount: 198,
          images: [
            'https://images.unsplash.com/photo-1515372039744-b8f02a3ae446?w=400',
          ],
          community: 'Christian',
          category: 'Dresses',
          sizes: ['XS', 'S', 'M', 'L', 'XL'],
          colors: ['#FFFFFF', '#F5F5DC', '#000080'],
          isVerified: true,
          hasTryOn: true,
          sellerName: 'Grace & Glory',
        ),
        Product(
          id: 'c2',
          name: 'Sterling Silver Cross Pendant',
          description:
              'Handcrafted .925 sterling silver cross pendant with cubic zirconia inlay. Comes with an 18" silver chain.',
          price: 1799,
          originalPrice: 2499,
          rating: 4.9,
          reviewCount: 345,
          images: [
            'https://images.unsplash.com/photo-1611591437281-460bfbe1220a?w=400',
          ],
          community: 'Christian',
          category: 'Jewellery',
          sizes: ['One Size'],
          colors: ['#C0C0C0', '#C9A84C'],
          isVerified: true,
          hasTryOn: false,
          sellerName: 'Blessed Gems',
        ),
        Product(
          id: 'c3',
          name: 'Men\'s Formal Sunday Suit',
          description:
              'Premium wool-blend suit for church and special occasions. Tailored fit, available in classic navy and charcoal.',
          price: 7999,
          originalPrice: 11999,
          rating: 4.7,
          reviewCount: 132,
          images: [
            'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400',
          ],
          community: 'Christian',
          category: 'Men\'s Wear',
          sizes: ['38', '40', '42', '44', '46'],
          colors: ['#000080', '#36454F', '#000000'],
          isVerified: true,
          hasTryOn: true,
          sellerName: 'Grace & Glory',
        ),
        Product(
          id: 'c4',
          name: 'Biblical Verse Wall Art',
          description:
              'Beautiful wooden wall art with inspirational Bible verses. Hand-carved and finished. Perfect for home or office.',
          price: 1299,
          originalPrice: 1899,
          rating: 4.8,
          reviewCount: 276,
          images: [
            'https://images.unsplash.com/photo-1561070791-2526d30994b5?w=400',
          ],
          community: 'Christian',
          category: 'Church Wear',
          sizes: ['Small', 'Medium', 'Large'],
          colors: ['#8B4513', '#D2691E', '#A0522D'],
          isVerified: true,
          hasTryOn: false,
          sellerName: 'Grace & Glory',
        ),
        Product(
          id: 'c5',
          name: 'Pearl Necklace - Holy Communion',
          description:
              'Delicate pearl necklace perfect for Holy Communion and confirmation ceremonies. Classic and timeless design.',
          price: 2499,
          originalPrice: 3699,
          rating: 4.9,
          reviewCount: 412,
          images: [
            'https://images.unsplash.com/photo-1535632066927-ab7c9ab60908?w=400',
          ],
          community: 'Christian',
          category: 'Jewellery',
          sizes: ['One Size'],
          colors: ['#FFFFFF', '#C0C0C0'],
          isVerified: true,
          hasTryOn: false,
          sellerName: 'Blessed Gems',
        ),
        // ══════════ BUDDHIST PRODUCTS ══════════
        Product(
          id: 'b1',
          name: 'Monk\'s Meditation Robe',
          description:
              'Traditional saffron meditation robe crafted from soft cotton. Simple, elegant, and mindfully made for practitioners.',
          price: 2799,
          originalPrice: 3999,
          rating: 4.8,
          reviewCount: 167,
          images: [
            'https://images.unsplash.com/photo-1508808703915-8c63e62cb6a6?w=400',
          ],
          community: 'Buddhist',
          category: 'Meditation Wear',
          sizes: ['S', 'M', 'L', 'XL'],
          colors: ['#FF8C00', '#C8860A', '#8B4513'],
          isVerified: true,
          hasTryOn: true,
          sellerName: 'Dharma Path',
        ),
        Product(
          id: 'b2',
          name: 'Bodhi Prayer Beads',
          description:
              'Genuine Bodhi seed mala with 108 beads and a guru bead. Hand-strung with silk thread. Blessed by Tibetan monks.',
          price: 1499,
          originalPrice: 2199,
          rating: 4.9,
          reviewCount: 289,
          images: [
            'https://images.unsplash.com/photo-1584551246679-0daf3d275d0f?w=400',
          ],
          community: 'Buddhist',
          category: 'Prayer Items',
          sizes: ['Standard'],
          colors: ['#8B4513', '#C9A84C'],
          isVerified: true,
          hasTryOn: false,
          sellerName: 'Dharma Path',
        ),
        Product(
          id: 'b3',
          name: 'Tibetan Singing Bowl',
          description:
              'Hand-hammered Tibetan singing bowl with wooden mallet and cushion. Resonates at 432Hz for deep meditation sessions.',
          price: 2299,
          originalPrice: 3299,
          rating: 4.9,
          reviewCount: 410,
          images: [
            'https://images.unsplash.com/photo-1555443805-658637491dd4?w=400',
          ],
          community: 'Buddhist',
          category: 'Meditation Tools',
          sizes: ['Small (4")', 'Medium (6")', 'Large (8")'],
          colors: ['#C9A84C', '#B87333'],
          isVerified: true,
          hasTryOn: false,
          sellerName: 'Om Shanti Store',
        ),
        Product(
          id: 'b4',
          name: 'Buddha Meditation Cushion',
          description:
              'Ergonomic zafu meditation cushion filled with buckwheat hulls. Promotes proper posture during meditation practice.',
          price: 3499,
          originalPrice: 5299,
          rating: 4.7,
          reviewCount: 198,
          images: [
            'https://images.unsplash.com/photo-1555686519-700f5b2e76a8?w=400',
          ],
          community: 'Buddhist',
          category: 'Meditation Wear',
          sizes: ['Standard'],
          colors: ['#FF8C00', '#C8860A'],
          isVerified: true,
          hasTryOn: false,
          sellerName: 'Dharma Path',
        ),
        // ══════════ HINDU PRODUCTS ══════════
        Product(
          id: 'h1',
          name: 'Banarasi Silk Saree',
          description:
              'Authentic Banarasi silk saree with real zari work. Passed through generations of Varanasi weavers. Perfect for weddings and festivals.',
          price: 8999,
          originalPrice: 12999,
          rating: 4.9,
          reviewCount: 445,
          images: [
            'https://images.unsplash.com/photo-1610030469983-98e550d6193c?w=400',
          ],
          community: 'Hindu',
          category: 'Sarees',
          sizes: ['Free Size (6m)'],
          colors: ['#8B0000', '#FF8C00', '#006400'],
          isVerified: true,
          hasTryOn: true,
          sellerName: 'Varanasi Heritage Weavers',
        ),
        Product(
          id: 'h2',
          name: 'Designer Anarkali Kurta',
          description:
              'Flared anarkali kurta in georgette fabric with mirror work. Comes with matching dupatta and churidar.',
          price: 3499,
          originalPrice: 5499,
          rating: 4.7,
          reviewCount: 320,
          images: [
            'https://images.unsplash.com/photo-1583391733956-3750e0ff4e8b?w=400',
          ],
          community: 'Hindu',
          category: 'Kurtas',
          sizes: ['XS', 'S', 'M', 'L', 'XL'],
          colors: ['#FF8C00', '#8B0000', '#4B0082'],
          isVerified: true,
          hasTryOn: true,
          sellerName: 'Rang Utsav',
        ),
        Product(
          id: 'h3',
          name: 'Puja Thali Set',
          description:
              'Handcrafted brass puja thali set with diya, bell, incense holder, and kumkum bowl. Engraved with Om symbol.',
          price: 1899,
          originalPrice: 2799,
          rating: 4.8,
          reviewCount: 560,
          images: [
            'https://images.unsplash.com/photo-1601127087940-59e81a3af78f?w=400',
          ],
          community: 'Hindu',
          category: 'Puja Items',
          sizes: ['Standard'],
          colors: ['#C9A84C', '#B87333'],
          isVerified: true,
          hasTryOn: false,
          sellerName: 'Devpuja Crafts',
        ),
        Product(
          id: 'h4',
          name: 'Men\'s Dhoti Kurta Set',
          description:
              'Premium cotton dhoti kurta set in ivory with golden border. Ideal for pujas, weddings, and festivals.',
          price: 2799,
          originalPrice: 3999,
          rating: 4.5,
          reviewCount: 210,
          images: [
            'https://images.unsplash.com/photo-1583500178690-594c236b6b60?w=400',
          ],
          community: 'Hindu',
          category: 'Men\'s Wear',
          sizes: ['S', 'M', 'L', 'XL', 'XXL'],
          colors: ['#FFFFF0', '#FFDAB9', '#F5DEB3'],
          isVerified: true,
          hasTryOn: true,
          sellerName: 'Rang Utsav',
        ),
        // ══════════ SIKH PRODUCTS ══════════
        Product(
          id: 's1',
          name: 'Premium Cotton Turban',
          description:
              'Hand-stitched pure cotton turban fabric in vibrant colours. 8 metres, ideal for Sikh dastar. Comfortable and long-lasting.',
          price: 1299,
          originalPrice: 1799,
          rating: 4.8,
          reviewCount: 275,
          images: [
            'https://images.unsplash.com/photo-1619033490422-4f90c7abb6b0?w=400',
          ],
          community: 'Sikh',
          category: 'Turban',
          sizes: ['5m', '6m', '7m', '8m'],
          colors: ['#006400', '#000080', '#8B0000', '#FF8C00', '#FFFFFF'],
          isVerified: true,
          hasTryOn: false,
          sellerName: 'Punjab Heritage',
        ),
        Product(
          id: 's2',
          name: 'Steel Kada',
          description:
              'Authentic stainless steel kara — one of the Five Ks of Sikhism. Smooth finish, available in different widths.',
          price: 599,
          originalPrice: 899,
          rating: 4.9,
          reviewCount: 620,
          images: [
            'https://images.unsplash.com/photo-1611591437281-460bfbe1220a?w=400',
          ],
          community: 'Sikh',
          category: 'Kara',
          sizes: ['Small', 'Medium', 'Large'],
          colors: ['#C0C0C0', '#C9A84C'],
          isVerified: true,
          hasTryOn: false,
          sellerName: 'Amritsar Crafts',
        ),
        Product(
          id: 's3',
          name: 'Punjabi Phulkari Dupatta',
          description:
              'Hand-embroidered Phulkari dupatta on georgette base. A traditional Punjabi art form with vibrant floral patterns.',
          price: 2499,
          originalPrice: 3499,
          rating: 4.7,
          reviewCount: 189,
          images: [
            'https://images.unsplash.com/photo-1596993100471-c3905dafa78e?w=400',
          ],
          community: 'Sikh',
          category: 'Accessories',
          sizes: ['Free Size'],
          colors: ['#FF8C00', '#8B0000', '#006400'],
          isVerified: true,
          hasTryOn: true,
          sellerName: 'Punjab Heritage',
        ),
        // ══════════ CHRISTIAN PRODUCTS ══════════
        Product(
          id: 'c1',
          name: 'Lace Church Dress',
          description:
              'Elegant lace overlay midi dress suitable for Sunday service, baptisms, and weddings. Modest neckline and long sleeves.',
          price: 3299,
          originalPrice: 4999,
          rating: 4.6,
          reviewCount: 198,
          images: [
            'https://images.unsplash.com/photo-1515372039744-b8f02a3ae446?w=400',
          ],
          community: 'Christian',
          category: 'Dresses',
          sizes: ['XS', 'S', 'M', 'L', 'XL'],
          colors: ['#FFFFFF', '#F5F5DC', '#000080'],
          isVerified: true,
          hasTryOn: true,
          sellerName: 'Grace & Glory',
        ),
        Product(
          id: 'c2',
          name: 'Sterling Silver Cross Pendant',
          description:
              'Handcrafted .925 sterling silver cross pendant with cubic zirconia inlay. Comes with an 18" silver chain.',
          price: 1799,
          originalPrice: 2499,
          rating: 4.9,
          reviewCount: 345,
          images: [
            'https://images.unsplash.com/photo-1611591437281-460bfbe1220a?w=400',
          ],
          community: 'Christian',
          category: 'Jewellery',
          sizes: ['One Size'],
          colors: ['#C0C0C0', '#C9A84C'],
          isVerified: true,
          hasTryOn: false,
          sellerName: 'Blessed Gems',
        ),
        Product(
          id: 'c3',
          name: 'Men\'s Formal Sunday Suit',
          description:
              'Premium wool-blend suit for church and special occasions. Tailored fit, available in classic navy and charcoal.',
          price: 7999,
          originalPrice: 11999,
          rating: 4.7,
          reviewCount: 132,
          images: [
            'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400',
          ],
          community: 'Christian',
          category: 'Men\'s Wear',
          sizes: ['38', '40', '42', '44', '46'],
          colors: ['#000080', '#36454F', '#000000'],
          isVerified: true,
          hasTryOn: true,
          sellerName: 'Grace & Glory',
        ),
        // ══════════ BUDDHIST PRODUCTS ══════════
        Product(
          id: 'b1',
          name: 'Monk\'s Meditation Robe',
          description:
              'Traditional saffron meditation robe crafted from soft cotton. Simple, elegant, and mindfully made for practitioners.',
          price: 2799,
          originalPrice: 3999,
          rating: 4.8,
          reviewCount: 167,
          images: [
            'https://images.unsplash.com/photo-1508808703915-8c63e62cb6a6?w=400',
          ],
          community: 'Buddhist',
          category: 'Meditation Wear',
          sizes: ['S', 'M', 'L', 'XL'],
          colors: ['#FF8C00', '#C8860A', '#8B4513'],
          isVerified: true,
          hasTryOn: true,
          sellerName: 'Dharma Path',
        ),
        Product(
          id: 'b2',
          name: 'Bodhi Prayer Beads',
          description:
              'Genuine Bodhi seed mala with 108 beads and a guru bead. Hand-strung with silk thread. Blessed by Tibetan monks.',
          price: 1499,
          originalPrice: 2199,
          rating: 4.9,
          reviewCount: 289,
          images: [
            'https://images.unsplash.com/photo-1584551246679-0daf3d275d0f?w=400',
          ],
          community: 'Buddhist',
          category: 'Prayer Items',
          sizes: ['Standard'],
          colors: ['#8B4513', '#C9A84C'],
          isVerified: true,
          hasTryOn: false,
          sellerName: 'Dharma Path',
        ),
        Product(
          id: 'b3',
          name: 'Tibetan Singing Bowl',
          description:
              'Hand-hammered Tibetan singing bowl with wooden mallet and cushion. Resonates at 432Hz for deep meditation sessions.',
          price: 2299,
          originalPrice: 3299,
          rating: 4.9,
          reviewCount: 410,
          images: [
            'https://images.unsplash.com/photo-1555443805-658637491dd4?w=400',
          ],
          community: 'Buddhist',
          category: 'Meditation Tools',
          sizes: ['Small (4")', 'Medium (6")', 'Large (8")'],
          colors: ['#C9A84C', '#B87333'],
          isVerified: true,
          hasTryOn: false,
          sellerName: 'Om Shanti Store',
        ),
      ];

  static List<String> getCategoriesForCommunity(String community) {
    switch (community) {
      case 'Muslim':
        return [
          'All',
          'Modest Wear',
          'Accessories',
          'Prayer Items',
          'Men\'s Wear',
          'Fragrance'
        ];
      case 'Hindu':
        return [
          'All',
          'Sarees',
          'Kurtas',
          'Puja Items',
          'Men\'s Wear',
          'Jewellery'
        ];
      case 'Sikh':
        return ['All', 'Turban', 'Kara', 'Accessories', 'Men\'s Wear'];
      case 'Christian':
        return ['All', 'Dresses', 'Jewellery', 'Men\'s Wear', 'Church Wear'];
      case 'Buddhist':
        return ['All', 'Meditation Wear', 'Prayer Items', 'Meditation Tools'];
      default:
        return ['All'];
    }
  }

  static Map<String, String> getFestivalInfo(String community) {
    switch (community) {
      case 'Muslim':
        return {
          'name': 'Eid Al-Adha',
          'date': '2026-06-15',
          'emoji': '🌙',
          'color': '#1a4a6e',
        };
      case 'Hindu':
        return {
          'name': 'Diwali',
          'date': '2026-11-08',
          'emoji': '🪔',
          'color': '#7a3500',
        };
      case 'Sikh':
        return {
          'name': 'Guru Nanak Jayanti',
          'date': '2026-11-30',
          'emoji': '🙏',
          'color': '#2d5a00',
        };
      case 'Christian':
        return {
          'name': 'Christmas',
          'date': '2026-12-25',
          'emoji': '⛪',
          'color': '#1a3a6e',
        };
      case 'Buddhist':
        return {
          'name': 'Vesak (Buddha\'s Birthday)',
          'date': '2026-05-03',
          'emoji': '☸️',
          'color': '#7a4a00',
        };
      default:
        return {
          'name': 'Festival',
          'date': '2026-12-25',
          'emoji': '🎉',
          'color': '#0D1B2A',
        };
    }
  }

  static String getGreeting(String community) {
    switch (community) {
      case 'Muslim':
        return 'Assalamu Alaikum';
      case 'Hindu':
        return 'Namaste 🙏';
      case 'Sikh':
        return 'Sat Sri Akaal';
      case 'Christian':
        return 'God Bless You ✝️';
      case 'Buddhist':
        return 'Namo Buddhaya ☸️';
      default:
        return 'Welcome';
    }
  }

  static List<Coupon> get coupons => [
        Coupon(
          id: 'c1',
          code: 'UMMIA20',
          title: '20% OFF on All Products',
          description: 'Exclusive deal for community members',
          discount: 20,
          discountType: 'percentage',
          minAmount: 500,
          expiryDate: DateTime(2026, 6, 30),
          applicableTo: ['Muslim', 'Hindu', 'Sikh', 'Christian', 'Buddhist'],
        ),
        Coupon(
          id: 'c2',
          code: 'MUSLIM15',
          title: 'Eid Special - 15% OFF',
          description: 'Celebrate Eid with special discounts',
          discount: 15,
          discountType: 'percentage',
          minAmount: 1000,
          expiryDate: DateTime(2026, 6, 20),
          applicableTo: ['Muslim'],
        ),
        Coupon(
          id: 'c3',
          code: 'DIWALI25',
          title: 'Diwali Bonanza - 25% OFF',
          description: 'Light up with amazing discounts',
          discount: 25,
          discountType: 'percentage',
          minAmount: 1500,
          expiryDate: DateTime(2026, 11, 15),
          applicableTo: ['Hindu'],
        ),
        Coupon(
          id: 'c4',
          code: 'GURU500',
          title: '₹500 OFF on purchases',
          description: 'Guru Nanak Jayanti special offer',
          discount: 500,
          discountType: 'fixed',
          minAmount: 2000,
          expiryDate: DateTime(2026, 12, 10),
          applicableTo: ['Sikh'],
        ),
        Coupon(
          id: 'c5',
          code: 'XMAS300',
          title: 'Christmas - ₹300 OFF',
          description: 'Spread joy this Christmas season',
          discount: 300,
          discountType: 'fixed',
          minAmount: 1000,
          expiryDate: DateTime(2026, 12, 25),
          applicableTo: ['Christian'],
        ),
        Coupon(
          id: 'c6',
          code: 'VESAK18',
          title: '18% OFF on Meditation Items',
          description: 'Find inner peace with our offerings',
          discount: 18,
          discountType: 'percentage',
          minAmount: 800,
          expiryDate: DateTime(2026, 5, 15),
          applicableTo: ['Buddhist'],
        ),
        Coupon(
          id: 'c7',
          code: 'WELCOME10',
          title: '10% First Order Discount',
          description: 'Welcome to Unity Cart family!',
          discount: 10,
          discountType: 'percentage',
          minAmount: 300,
          expiryDate: DateTime(2026, 12, 31),
          applicableTo: ['Muslim', 'Hindu', 'Sikh', 'Christian', 'Buddhist'],
        ),
        Coupon(
          id: 'c8',
          code: 'SUMMER30',
          title: '30% OFF on selected items',
          description: 'Summer collection special sale',
          discount: 30,
          discountType: 'percentage',
          minAmount: 2000,
          expiryDate: DateTime(2026, 7, 31),
          applicableTo: ['Muslim', 'Hindu', 'Sikh', 'Christian', 'Buddhist'],
        ),
      ];

  static List<Coupon> getRandomCoupons(String community, {int count = 2}) {
    final applicable = coupons
        .where((c) => c.applicableTo.contains(community) && !c.isExpired)
        .toList();
    applicable.shuffle();
    return applicable.take(count).toList();
  }
}
