// lib/models/product.dart

class Product {
  final String id;
  final String name;
  final String category;
  final String tag;
  final String subTag;
  final double price;
  final String image;
  final String description;
  final List<String> details;
  final int stock;

  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.tag,
    required this.subTag,
    required this.price,
    required this.image,
    required this.description,
    required this.details,
    required this.stock,
  });

  bool get featured => tag == 'featured';
  bool get inStock => stock > 0;
  String get formattedPrice => 'R ${price.toStringAsFixed(0)}';
}

// ─── PURSES LIST ──────────────────────────────────────────────────────────────
// Replace image URLs with your own Pexels links before publishing.
const List<Product> kPurses = [
  // ── TOTE BAGS ─────────────────────────────────────────
  Product(
    id: 'p1',
    name: 'Classic Leather Tote',
    category: 'purses',
    tag: 'featured',
    subTag: 'tote',
    price: 1200,
    image:
        'https://images.pexels.com/photos/22432987/pexels-photo-22432987.jpeg',
    description:
        'A timeless everyday tote in genuine leather. Spacious, structured, and endlessly versatile — the bag you reach for every single day.',
    details: [
      'Genuine leather',
      'Interior zip pocket',
      'Magnetic snap closure',
      '40cm × 32cm × 14cm',
      'Shoulder & hand carry'
    ],
    stock: 10,
  ),
  Product(
    id: 'p2',
    name: 'Canvas Weekend Tote',
    category: 'purses',
    tag: 'featured',
    subTag: 'tote',
    price: 650,
    image:
        'https://images.pexels.com/photos/36385200/pexels-photo-36385200.jpeg',
    description:
        'Heavy-duty canvas tote perfect for the market, gym, or a weekend away. Wipe-clean lining and reinforced handles.',
    details: [
      'Premium canvas',
      'Wipe-clean lining',
      'Open top with snap',
      '45cm × 38cm × 12cm',
      'Double stitched handles'
    ],
    stock: 15,
  ),
  Product(
    id: 'p3',
    name: 'Structured Office Tote',
    category: 'purses',
    tag: 'tote',
    subTag: 'tote',
    price: 1450,
    image:
        'https://images.pexels.com/photos/36364965/pexels-photo-36364965.jpeg',
    description:
        'Sharp, professional, and seriously spacious. Fits a 15" laptop plus all your essentials — without sacrificing style.',
    details: [
      'Vegan leather',
      'Padded laptop sleeve',
      'Multiple card slots',
      '42cm × 34cm × 16cm',
      'Top zip closure'
    ],
    stock: 7,
  ),
  Product(
    id: 'p4',
    name: 'Mini Leather Tote',
    category: 'purses',
    tag: 'tote',
    subTag: 'tote',
    price: 850,
    image:
        'https://images.pexels.com/photos/22432988/pexels-photo-22432988.jpeg',
    description:
        'All the elegance of a classic tote in a compact, cute size. Perfect for days when you only need the essentials.',
    details: [
      'Genuine leather',
      'Internal divider',
      'Gold hardware',
      '28cm × 22cm × 10cm',
      'Top handle carry'
    ],
    stock: 8,
  ),

  // ── CROSSBODY BAGS ────────────────────────────────────
  Product(
    id: 'p5',
    name: 'Quilted Chain Crossbody',
    category: 'purses',
    tag: 'featured',
    subTag: 'crossbody',
    price: 990,
    image:
        'https://images.pexels.com/photos/31929486/pexels-photo-31929486.jpeg',
    description:
        'Chic quilted texture with a gold chain strap that dresses up any outfit — day or night. Compact but fits more than you think.',
    details: [
      'Quilted vegan leather',
      'Gold chain strap',
      'Flap with magnetic snap',
      '24cm × 16cm × 7cm',
      'Interior slip pockets'
    ],
    stock: 9,
  ),
  Product(
    id: 'p6',
    name: 'Saddle Crossbody Bag',
    category: 'purses',
    tag: 'featured',
    subTag: 'crossbody',
    price: 780,
    image: 'https://images.pexels.com/photos/9267587/pexels-photo-9267587.jpeg',
    description:
        'A Western-inspired saddle silhouette with a modern edge. Worn crossbody or on the shoulder — both equally stunning.',
    details: [
      'Full-grain leather',
      'Adjustable strap',
      'Zip + flap closure',
      '26cm × 20cm × 8cm',
      'Antique brass hardware'
    ],
    stock: 6,
  ),
  Product(
    id: 'p7',
    name: 'Compact Zip Crossbody',
    category: 'purses',
    tag: 'crossbody',
    subTag: 'crossbody',
    price: 560,
    image:
        'https://images.pexels.com/photos/27174548/pexels-photo-27174548.jpeg',
    description:
        'Minimalist zip crossbody for the woman on the go. Lightweight, secure, and just the right size for your phone, cards, and keys.',
    details: [
      'Smooth vegan leather',
      'Top zip closure',
      'Front zip pocket',
      '22cm × 14cm × 5cm',
      'Adjustable strap'
    ],
    stock: 12,
  ),
  Product(
    id: 'p8',
    name: 'Woven Straw Crossbody',
    category: 'purses',
    tag: 'crossbody',
    subTag: 'crossbody',
    price: 480,
    image:
        'https://images.pexels.com/photos/31525074/pexels-photo-31525074.jpeg',
    description:
        'Handwoven natural straw crossbody — your perfect summer companion. Lightweight and effortlessly boho-chic.',
    details: [
      'Natural straw weave',
      'Leather trim detail',
      'Magnetic clasp',
      '25cm × 18cm × 8cm',
      'Cotton lining'
    ],
    stock: 5,
  ),

  // ── CLUTCHES ──────────────────────────────────────────
  Product(
    id: 'p9',
    name: 'Evening Satin Clutch',
    category: 'purses',
    tag: 'featured',
    subTag: 'clutch',
    price: 420,
    image: 'https://images.pexels.com/photos/1358840/pexels-photo-1358840.jpeg',
    description:
        'Sleek satin clutch that elevates every formal occasion. Fits your phone, cards, and lipstick — everything you need for a night out.',
    details: [
      'Satin fabric',
      'Gold frame clasp',
      'Detachable wrist strap',
      '22cm × 12cm × 3cm',
      'Fully lined interior'
    ],
    stock: 10,
  ),
  Product(
    id: 'p10',
    name: 'Embroidered Boho Clutch',
    category: 'purses',
    tag: 'clutch',
    subTag: 'clutch',
    price: 390,
    image:
        'https://images.pexels.com/photos/30975790/pexels-photo-30975790.jpeg',
    description:
        'Hand-embroidered  — a one-of-a-kind clutch that is a conversation starter wherever you go.',
    details: [
      'Hand-embroidered cotton',
      'Zip closure',
      'Wrist strap included',
      '24cm × 14cm × 3cm',
      'Colourful floral detail'
    ],
    stock: 4,
  ),
  Product(
    id: 'p11',
    name: 'Gold Clutch',
    category: 'purses',
    tag: 'featured',
    subTag: 'clutch',
    price: 350,
    image: 'https://images.pexels.com/photos/4627902/pexels-photo-4627902.jpeg',
    description:
        'Gold clutch. Goes from cocktails to dinner without missing a beat.',
    details: [
      'Metallic vegan leather',
      'Fold-over magnetic closure',
      'Card slots inside',
      '28cm × 15cm × 4cm',
      'Chain wrist strap'
    ],
    stock: 7,
  ),

  // ── SHOULDER BAGS ─────────────────────────────────────
  Product(
    id: 'p12',
    name: 'Cute bucket purse',
    category: 'purses',
    tag: 'featured',
    subTag: 'shoulder',
    price: 1100,
    image:
        'https://images.pexels.com/photos/35666033/pexels-photo-35666033.jpeg',
    description:
        'Slouchy, soft hobo silhouette in buttery leather. Effortlessly cool and roomy enough for everything you carry on the daily.',
    details: [
      'Soft genuine leather',
      'Single shoulder strap',
      'Zip top closure',
      '38cm × 28cm × 12cm',
      'Suede interior'
    ],
    stock: 6,
  ),
  Product(
    id: 'p13',
    name: 'Half-Moon Shoulder Bag',
    category: 'purses',
    tag: 'shoulder',
    subTag: 'shoulder',
    price: 870,
    image: 'https://images.pexels.com/photos/8396731/pexels-photo-8396731.jpeg',
    description:
        'The curved half-moon silhouette adds instant elegance to any look. Structured yet lightweight — a modern classic.',
    details: [
      'Vegan leather',
      'Adjustable shoulder strap',
      'Magnetic snap flap',
      '32cm × 20cm × 10cm',
      'Signature lining'
    ],
    stock: 8,
  ),
  Product(
    id: 'p14',
    name: 'Fringe Boho Shoulder Bag',
    category: 'purses',
    tag: 'shoulder',
    subTag: 'shoulder',
    price: 720,
    image:
        'https://images.pexels.com/photos/14146710/pexels-photo-14146710.jpeg',
    description:
        'Long fringe detail and earthy tones for the free-spirited fashionista. This bag makes a statement without saying a word.',
    details: [
      'Suede-effect fabric',
      'Fringe trim detail',
      'Drawstring + snap closure',
      '30cm × 26cm × 8cm',
      'Adjustable strap'
    ],
    stock: 5,
  ),
  Product(
    id: 'p15',
    name: 'Mini Barrel Shoulder Bag',
    category: 'purses',
    tag: 'shoulder',
    subTag: 'shoulder',
    price: 640,
    image:
        'https://images.pexels.com/photos/12471928/pexels-photo-12471928.jpeg',
    description:
        'Cute cylindrical barrel shape that stands out in a crowd. Fits your essentials and makes every outfit look intentional.',
    details: [
      'Smooth faux leather',
      'Zip closure',
      'Short shoulder strap',
      '20cm × 14cm diameter',
      'Gold zip pull'
    ],
    stock: 9,
  ),

  // ── BUCKET BAGS ───────────────────────────────────────
  Product(
    id: 'p16',
    name: 'Leather Bucket Bag',
    category: 'purses',
    tag: 'featured',
    subTag: 'bucket',
    price: 950,
    image:
        'https://images.pexels.com/photos/11124972/pexels-photo-11124972.jpeg',
    description:
        'The iconic bucket silhouette reinvented in premium leather. Roomy, practical, and looking luxurious while doing it.',
    details: [
      'Genuine leather',
      'Drawstring closure',
      'Interior zip pocket',
      '28cm × 30cm',
      'Shoulder & crossbody strap'
    ],
    stock: 7,
  ),
  Product(
    id: 'p17',
    name: 'Suede Drawstring Bucket',
    category: 'purses',
    tag: 'bucket',
    subTag: 'bucket',
    price: 820,
    image:
        'https://images.pexels.com/photos/19976270/pexels-photo-19976270.jpeg',
    description:
        'Soft suede bucket bag with a relaxed drawstring closure. Rich texture, earthy tones — autumn style perfected.',
    details: [
      'Genuine suede',
      'Drawstring top',
      'Tassel detail',
      '26cm × 28cm',
      'Single shoulder strap'
    ],
    stock: 4,
  ),

  // ── BACKPACK PURSES ───────────────────────────────────
  Product(
    id: 'p18',
    name: 'Shoulder bag',
    category: 'purses',
    tag: 'featured',
    subTag: 'backpack',
    price: 1350,
    image:
        'https://images.pexels.com/photos/17792786/pexels-photo-17792786.jpeg',
    description:
        'Fashion-forward mini shoulder bag that keeps your hands free without compromising on style. Converts to a shoulder bag too.',
    details: [
      'Genuine leather',
      'Zip closure',
      'Front zip pocket',
      '26cm × 30cm × 10cm',
      'Converts to shoulder bag'
    ],
    stock: 6,
  ),
  Product(
    id: 'p19',
    name: 'Quilted  Purse',
    category: 'purses',
    tag: 'backpack',
    subTag: 'backpack',
    price: 1050,
    image:
        'https://images.pexels.com/photos/20722001/pexels-photo-20722001.jpeg',
    description:
        'Quilted diamond-stitch design in a compact backpack silhouette. Practical for travel, polished for brunch.',
    details: [
      'Quilted vegan leather',
      'Top handle + backpack straps',
      'Magnetic snap flap',
      '24cm × 28cm × 10cm',
      'Gold hardware'
    ],
    stock: 8,
  ),
  Product(
    id: 'p20',
    name: 'Croc-Embossed purse',
    category: 'purses',
    tag: 'backpack',
    subTag: 'backpack',
    price: 1180,
    image:
        'https://images.pexels.com/photos/30975839/pexels-photo-30975839.jpeg',
    description:
        'Bold croc-embossed texture gives this purse serious luxury energy. Structured, sleek, and completely unique.',
    details: [
      'Croc-embossed vegan leather',
      'Zip closure',
      'Two main compartments',
      '25cm × 30cm × 12cm',
      'Adjustable straps'
    ],
    stock: 5,
  ),
];

// ─── WEAVES LIST ─────────────────────────────────────────────────────────────
const List<Product> kWeaves = [
  // ── WAVY ─────────────────────────────────────────────
  Product(
    id: 'w1',
    name: 'Brazilian Body Wave Bundles',
    category: 'weaves',
    tag: 'featured',
    subTag: 'wavy',
    price: 2500,
    image:
        'https://images.pexels.com/photos/12698463/pexels-photo-12698463.png',
    description:
        'Our #1 bestselling weave. 100% virgin Brazilian body wave — full, bouncy S-waves that hold their shape and look incredible every single day.',
    details: [
      '100% Virgin Brazilian Hair',
      '3 Bundles (12", 14", 16")',
      'Natural Black (1B)',
      'Lasts 12–18 months',
      'Body wave pattern'
    ],
    stock: 8,
  ),
  Product(
    id: 'w9',
    name: 'Closure Bundle Deal – Body Wave',
    category: 'weaves',
    tag: 'wavy',
    subTag: 'wavy',
    price: 3200,
    image: 'https://images.pexels.com/photos/4130535/pexels-photo-4130535.jpeg',
    description:
        'Everything you need for a complete, flawless install — 3 body wave bundles PLUS a matching 4×4 lace closure. Unbeatable value.',
    details: [
      '3 Bundles + 4×4 Lace Closure',
      '100% Virgin Hair',
      '12", 14", 16" + 12" closure',
      'Natural Black (1B)',
      'Body wave texture'
    ],
    stock: 4,
  ),
  Product(
    id: 'w12',
    name: 'Water Wave Bundles',
    category: 'weaves',
    tag: 'wavy',
    subTag: 'wavy',
    price: 2400,
    image:
        'https://images.pexels.com/photos/15071824/pexels-photo-15071824.jpeg',
    description:
        'Beautiful wet-and-wavy water wave texture — stunning straight out of the shower and equally gorgeous when air-dried.',
    details: [
      '100% Virgin Brazilian Hair',
      '3 Bundles (12", 14", 16")',
      'Natural Black (1B)',
      'Water wave texture',
      'Minimal tangling'
    ],
    stock: 4,
  ),
  Product(
    id: 'w13',
    name: 'Loose Deep Wave Bundles',
    category: 'weaves',
    tag: 'wavy',
    subTag: 'wavy',
    price: 2550,
    image: 'https://images.pexels.com/photos/5619263/pexels-photo-5619263.jpeg',
    description:
        'Glamorous loose deep waves with serious volume and movement. Think red carpet — but make it everyday.',
    details: [
      '100% Virgin Hair',
      '3 Bundles (14", 16", 18")',
      'Natural Black (1B)',
      'Loose deep wave texture',
      'Can be bleached & dyed'
    ],
    stock: 3,
  ),
  Product(
    id: 'w20',
    name: 'U-Part Wig – Body Wave',
    category: 'weaves',
    tag: 'wavy',
    subTag: 'wavy',
    price: 2800,
    image:
        'https://images.pexels.com/photos/16572818/pexels-photo-16572818.jpeg',
    description:
        'The most natural-looking install possible — blend your own edges through the U-part for an undetectable finish.',
    details: [
      '100% Virgin Hair',
      'U-part opening',
      '22" length',
      'Natural Black (1B)',
      'Body wave pattern'
    ],
    stock: 2,
  ),

  // ── STRAIGHT ──────────────────────────────────────────
  Product(
    id: 'w2',
    name: 'Peruvian Silky Straight',
    category: 'weaves',
    tag: 'featured',
    subTag: 'straight',
    price: 2200,
    image:
        'https://images.pexels.com/photos/36288155/pexels-photo-36288155.jpeg',
    description:
        'Lightweight, sleek Peruvian virgin hair that reflects light like a dream. Heat-friendly and endlessly versatile.',
    details: [
      '100% Virgin Peruvian Hair',
      '3 Bundles (14", 16", 18")',
      'Natural Black (1B)',
      'Heat-friendly up to 180°C',
      'Silky straight texture'
    ],
    stock: 10,
  ),
  Product(
    id: 'w5',
    name: 'Tape-In Extensions – Straight',
    category: 'weaves',
    tag: 'featured',
    subTag: 'straight',
    price: 2600,
    image:
        'https://images.pexels.com/photos/14730878/pexels-photo-14730878.jpeg',
    description:
        'Seamless tape-in extensions for a perfectly flat, natural install. Reusable up to 3 times — great value and even better results.',
    details: [
      '100% Remy Human Hair',
      '20 pieces per pack',
      '18" length',
      'Natural Black (1B)',
      'Tape-in method'
    ],
    stock: 9,
  ),
  Product(
    id: 'w6',
    name: 'Micro Link I-Tip Extensions',
    category: 'weaves',
    tag: 'straight',
    subTag: 'straight',
    price: 2800,
    image:
        'https://images.pexels.com/photos/18614263/pexels-photo-18614263.jpeg',
    description:
        'No heat, no glue. Individual micro link beads for the most natural-looking, damage-free install on the market.',
    details: [
      '100% Remy Human Hair',
      '100 individual strands',
      '20" length',
      'Natural Black (1B)',
      'I-tip micro links'
    ],
    stock: 12,
  ),
  Product(
    id: 'w10',
    name: 'Clip-In Extensions Set',
    category: 'weaves',
    tag: 'straight',
    subTag: 'straight',
    price: 1800,
    image:
        'https://i.pinimg.com/736x/2a/32/ac/2a32ac86746b89aafbf0ee5e6222ab45.jpg',
    description:
        'Instant length and volume in minutes — no salon, no stylist. This 7-piece clip-in set is your secret weapon for big hair days.',
    details: [
      '100% Remy Human Hair',
      '7-piece set',
      '22" length',
      'Natural Black (1B)',
      'Clip-in method'
    ],
    stock: 6,
  ),
  Product(
    id: 'w14',
    name: 'Bold Pixie Cut Wig',
    category: 'weaves',
    tag: 'straight',
    subTag: 'straight',
    price: 1500,
    image:
        'https://images.pexels.com/photos/17362828/pexels-photo-17362828.jpeg',
    description:
        'For the bold and the fearless. A chic layered pixie cut in a full lace cap — maximum impact with zero effort.',
    details: [
      '100% Human Hair',
      'Full lace cap',
      '6" layered length',
      'Natural Black (1B)',
      'Cropped pixie cut'
    ],
    stock: 10,
  ),
  Product(
    id: 'w18',
    name: 'Bone Straight Bundles',
    category: 'weaves',
    tag: 'straight',
    subTag: 'straight',
    price: 2650,
    image:
        'https://images.pexels.com/photos/31578453/pexels-photo-31578453.jpeg',
    description:
        'Ultra-sleek, mirror-finish straight hair for the woman who means business. Zero frizz, maximum polish.',
    details: [
      '100% Virgin Brazilian Hair',
      '3 Bundles (18", 20", 22")',
      'Natural Black (1B)',
      'Bone straight texture',
      'Frizz-free finish'
    ],
    stock: 4,
  ),
  Product(
    id: 'w16',
    name: '360 Lace Frontal Wig – Straight',
    category: 'weaves',
    tag: 'featured',
    subTag: 'straight',
    price: 4500,
    image:
        'https://images.pexels.com/photos/17362825/pexels-photo-17362825.jpeg',
    description:
        'Full 360° lace coverage means you can pull it into a high ponytail, bun, or updo — undetectable from every angle.',
    details: [
      '360 HD Lace Frontal',
      '100% Virgin Hair',
      '24" length',
      'Natural Black (1B)',
      'Silky straight texture'
    ],
    stock: 7,
  ),
  Product(
    id: 'w19',
    name: 'Headband Wig – Straight',
    category: 'weaves',
    tag: 'featured',
    subTag: 'straight',
    price: 2100,
    image:
        'https://images.pexels.com/photos/34605811/pexels-photo-34605811.jpeg',
    description:
        'No glue, no lace, no stress. Slide on this straight headband wig and walk out the door looking flawless in under 5 minutes.',
    details: [
      '100% Human Hair',
      'Velvet headband included',
      '20" length',
      'Natural Black (1B)',
      'Silky straight texture'
    ],
    stock: 3,
  ),

  // ── CURLY ─────────────────────────────────────────────
  Product(
    id: 'w3',
    name: 'Deep Wave Headband Wig',
    category: 'weaves',
    tag: 'featured',
    subTag: 'curly',
    price: 2900,
    image:
        'https://images.pexels.com/photos/11482798/pexels-photo-11482798.jpeg',
    description:
        'Defined, sultry deep wave curls in a no-fuss headband wig. No glue, no lace, no stylist — just gorgeous hair in minutes.',
    details: [
      '100% Human Hair',
      'Velvet headband attached',
      '18" length',
      'Natural Black (1B)',
      'Deep wave texture'
    ],
    stock: 7,
  ),
  Product(
    id: 'w4',
    name: 'Malaysian Kinky Curly Bundles',
    category: 'weaves',
    tag: 'featured',
    subTag: 'curly',
    price: 2700,
    image:
        'https://images.pexels.com/photos/34027411/pexels-photo-34027411.jpeg',
    description:
        'Natural kinky curly texture that blends seamlessly with 4B/4C hair. Voluminous, defined, and authentically beautiful.',
    details: [
      '100% Virgin Malaysian Hair',
      '3 Bundles (10", 12", 14")',
      'Natural Black (1B)',
      '4B/4C curl pattern',
      'Minimal shedding'
    ],
    stock: 6,
  ),
  Product(
    id: 'w7',
    name: 'Jerry Curl Bundles',
    category: 'weaves',
    tag: 'curly',
    subTag: 'curly',
    price: 2350,
    image: 'https://images.pexels.com/photos/7440128/pexels-photo-7440128.jpeg',
    description:
        'Tight, glossy, defined jerry curls for a classic retro look that never goes out of style. Low maintenance and long-lasting.',
    details: [
      '100% Virgin Human Hair',
      '3 Bundles (10", 12", 14")',
      'Natural Black (1B)',
      'Jerry curl pattern',
      'Can be dyed'
    ],
    stock: 5,
  ),
  Product(
    id: 'w8',
    name: 'Bohemian Curl Lace Front Wig',
    category: 'weaves',
    tag: 'featured',
    subTag: 'curly',
    price: 3800,
    image:
        'https://images.pexels.com/photos/36170284/pexels-photo-36170284.jpeg',
    description:
        'Effortless bohemian curls in a ready-to-wear lace front wig. For the free spirit who still wants to look polished.',
    details: [
      '100% Human Hair',
      'Lace front wig',
      '20" length',
      'Natural Black (1B)',
      'Bohemian curl pattern'
    ],
    stock: 8,
  ),
  Product(
    id: 'w11',
    name: 'HD Lace Frontal Wig – Wavy',
    category: 'weaves',
    tag: 'featured',
    subTag: 'curly',
    price: 4200,
    image:
        'https://images.pexels.com/photos/31087597/pexels-photo-31087597.jpeg',
    description:
        'Ultra-thin HD lace that literally disappears into your skin. The most natural, undetectable hairline you have ever seen.',
    details: [
      '13×6 HD Lace Frontal',
      '100% Virgin Hair',
      '22" length',
      'Natural Black (1B)',
      'Pre-plucked natural hairline'
    ],
    stock: 5,
  ),
];

// Combine all products
const List<Product> allProducts = [...kPurses, ...kWeaves];
