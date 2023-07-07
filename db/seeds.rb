user1 = User.create(name: 'Dico Diaz', email: 'dicodiaz@gmail.com', password: 'test123')
user2 = User.create(name: 'Amanda Lopez', email: 'amandalopez@gmail.com', password: 'test123')

category1 = Category.create(name: 'Food',
                            icon: 'https://i.pinimg.com/originals/fd/80/ec/fd80ecec48eba2a9adb76e4133905879.png', user: user1)
category2 = Category.create(name: 'Health',
                            icon: 'https://static.vecteezy.com/system/resources/previews/004/413/150/original/simple-illustration-that-prevent-heart-attack-heart-health-cardiology-outlined-icon-free-vector.jpg', user: user1)
category3 = Category.create(name: 'Health',
                            icon: 'https://icons.veryicon.com/png/o/business/circular-multi-color-function-icon/health-health.png', user: user2)
category4 = Category.create(name: 'Fashion',
                            icon: 'https://static.vecteezy.com/system/resources/previews/003/600/897/original/women-fashion-color-icon-vector.jpg', user: user2)

purchase1 = Purchase.create(name: 'Movich dinner', amount: 46.08, author: user1)
purchase2 = Purchase.create(name: 'Doctor appointment', amount: 6.24, author: user1)
purchase3 = Purchase.create(name: 'Medicines', amount: 17.76, author: user2)
purchase4 = Purchase.create(name: 'Shoes', amount: 44.40, author: user2)

purchase_category_1 = PurchaseCategory.create(category: category1, purchase: purchase1)
purchase_category_2 = PurchaseCategory.create(category: category2, purchase: purchase2)
purchase_category_3 = PurchaseCategory.create(category: category3, purchase: purchase3)
purchase_category_4 = PurchaseCategory.create(category: category4, purchase: purchase4)
