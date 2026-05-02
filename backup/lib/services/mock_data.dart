import '../models/product.dart';

class MockData {
  static List<Product> get allProducts => [
        // ══════════ MUSLIM PRODUCTS ══════════
        Product(
          id: 'm1',
          name: 'Elegant Abaya',
          description:
              'Elegant black abaya with intricate gold embroidery on cuffs and hem. Premium chiffon fabric, modest and graceful.',
          price: 2499,
          originalPrice: 3499,
          rating: 4.8,
          reviewCount: 312,
          images: [
            'https://dummyimage.com/400x400/1a1a2e/C9A84C.png&text=Elegant+Abaya',
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
            'https://dummyimage.com/400x400/4a0e4e/ffffff.png&text=Silk+Hijab',
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
            'https://dummyimage.com/400x400/C9A84C/ffffff.png&text=Crystal+Tasbeeh',
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
          name: "Men's Kandura",
          description:
              'Premium white kandura crafted from Egyptian cotton. Perfectly tailored for comfort and elegance during prayers and occasions.',
          price: 3199,
          originalPrice: 4299,
          rating: 4.6,
          reviewCount: 188,
          images: [
            'https://dummyimage.com/400x400/F5F5DC/1a1a2e.png&text=Mens+Kandura',
          ],
          community: 'Muslim',
          category: "Men's Wear",
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
            'https://dummyimage.com/400x400/8B4513/C9A84C.png&text=Oud+Perfume',
          ],
          community: 'Muslim',
          category: 'Fragrance',
          sizes: ['3ml', '6ml', '12ml'],
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
            'https://dummyimage.com/400x400/8B0000/C9A84C.png&text=Banarasi+Saree',
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
            'https://dummyimage.com/400x400/FF8C00/ffffff.png&text=Anarkali+Kurta',
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
            'https://dummyimage.com/400x400/B87333/ffffff.png&text=Puja+Thali',
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
          name: "Men's Dhoti Kurta Set",
          description:
              'Premium cotton dhoti kurta set in ivory with golden border. Ideal for pujas, weddings, and festivals.',
          price: 2799,
          originalPrice: 3999,
          rating: 4.5,
          reviewCount: 210,
          images: [
            'https://dummyimage.com/400x400/FFFFF0/8B4513.png&text=Dhoti+Kurta',
          ],
          community: 'Hindu',
          category: "Men's Wear",
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
            'https://dummyimage.com/400x400/FF8C00/ffffff.png&text=Cotton+Turban',
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
            'https://dummyimage.com/400x400/C0C0C0/1a1a2e.png&text=Steel+Kada',
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
            'https://dummyimage.com/400x400/FF8C00/ffffff.png&text=Phulkari',
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
            'https://dummyimage.com/400x400/F5F5DC/000080.png&text=Church+Dress',
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
            'https://dummyimage.com/400x400/C0C0C0/1a1a2e.png&text=Cross+Pendant',
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
          name: "Men's Formal Sunday Suit",
          description:
              'Premium wool-blend suit for church and special occasions. Tailored fit, available in classic navy and charcoal.',
          price: 7999,
          originalPrice: 11999,
          rating: 4.7,
          reviewCount: 132,
          images: [
            'https://dummyimage.com/400x400/000080/ffffff.png&text=Sunday+Suit',
          ],
          community: 'Christian',
          category: "Men's Wear",
          sizes: ['38', '40', '42', '44', '46'],
          colors: ['#000080', '#36454F', '#000000'],
          isVerified: true,
          hasTryOn: true,
          sellerName: 'Grace & Glory',
        ),
        // ══════════ BUDDHIST PRODUCTS ══════════
        Product(
          id: 'b1',
          name: "Monk's Meditation Robe",
          description:
              'Traditional saffron meditation robe crafted from soft cotton. Simple, elegant, and mindfully made for practitioners.',
          price: 2799,
          originalPrice: 3999,
          rating: 4.8,
          reviewCount: 167,
          images: [
            'https://dummyimage.com/400x400/FF8C00/ffffff.png&text=Meditation+Robe',
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
            'https://dummyimage.com/400x400/8B4513/C9A84C.png&text=Bodhi+Mala',
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
            'https://dummyimage.com/400x400/C9A84C/ffffff.png&text=Singing+Bowl',
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
        return ['All', 'Modest Wear', 'Accessories', 'Prayer Items', "Men's Wear", 'Fragrance'];
      case 'Hindu':
        return ['All', 'Sarees', 'Kurtas', 'Puja Items', "Men's Wear", 'Jewellery'];
      case 'Sikh':
        return ['All', 'Turban', 'Kara', 'Accessories', "Men's Wear"];
      case 'Christian':
        return ['All', 'Dresses', 'Jewellery', "Men's Wear", 'Church Wear'];
      case 'Buddhist':
        return ['All', 'Meditation Wear', 'Prayer Items', 'Meditation Tools'];
      default:
        return ['All'];
    }
  }

  static Map<String, String> getFestivalInfo(String community) {
    switch (community) {
      case 'Muslim':
        return {'name': 'Eid Al-Adha', 'date': '2025-06-06', 'emoji': '🌙', 'color': '#1a4a6e'};
      case 'Hindu':
        return {'name': 'Diwali', 'date': '2025-10-20', 'emoji': '🪔', 'color': '#7a3500'};
      case 'Sikh':
        return {'name': 'Gurpurab', 'date': '2025-11-05', 'emoji': '🙏', 'color': '#2d5a00'};
      case 'Christian':
        return {'name': 'Christmas', 'date': '2025-12-25', 'emoji': '⛪', 'color': '#1a3a6e'};
      case 'Buddhist':
        return {'name': 'Vesak', 'date': '2025-05-12', 'emoji': '☸️', 'color': '#7a4a00'};
      default:
        return {'name': 'Festival', 'date': '2025-12-25', 'emoji': '🎉', 'color': '#0D1B2A'};
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
}