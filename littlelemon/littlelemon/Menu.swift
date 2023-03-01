import SwiftUI

struct Menu: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var searchText = ""
    
    var body: some View {
        VStack{
            HStack {
                VStack{
                    Text("Little Lemon").bold().font(.custom("Optima", size: 26)).foregroundColor(.green).frame(width:290, alignment: .topLeading)
                    Text("Chicago").font(.title3).italic().foregroundColor(.yellow).frame(width: 200, alignment: .leading)
                }
                Image("lemon").resizable().frame(width:60, height: 60)
            }
            .padding(.bottom)
            Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.").foregroundColor(.white).background(Color.green).font(.title2).frame(alignment: .trailing).shadow(color: .yellow, radius: 3)
            
            TextField("Search Menu...", text: $searchText)
            
            FetchedObjects(
                predicate: buildPredicate(),
                sortDescriptors: buildSortDescriptors()) { (dishes: [Dish]) in
                    List{
                        ForEach(dishes){dish in
                            HStack{
                                Spacer()
                            
                                VStack{
                                    Text("\(dish.title ?? "dish")")
                                    Text("$\(dish.price ?? "0.00")")
                                }.frame(width: 100, height: 100)
                                
                                Spacer()
                                
                                AsyncImage(url: URL(string: dish.image!)) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                }placeholder: {
                                    Image("")
                                }.frame(width: 200, height: 100)
                                Spacer()
                            }
                        }
                }
            }
            
        }.onAppear{
            getMenuData()
        }
            
       
    }
    
    func getMenuData(){
        
        PersistenceController.shared.clear()
       
        let url = URL(string: "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json")
        
        let urlRequest = URLRequest(url: url!)
        
        let urlTask = URLSession.shared.dataTask(with: urlRequest){ data, response, error in
             
            if let data = data{
                let decoder = try! JSONDecoder().decode(MenuList.self, from: data)
                
                decoder.menu.forEach { item in
                    let dish = Dish(context: viewContext)
                    dish.title = item.title
                    dish.price = item.price
                    dish.image = item.image
                }
                
                try? viewContext.save()
            }
        }
        
        urlTask.resume()
    }
    
    func buildSortDescriptors() -> [NSSortDescriptor]{
        
        return[NSSortDescriptor(key: "title", ascending: true, selector: #selector(NSString.localizedStandardCompare))]
    }
    
    func buildPredicate() -> NSPredicate{
        if searchText.isEmpty{
            return NSPredicate(value: true)
        }
        else{
            return NSPredicate(format:"title CONTAINS[cd] %@", searchText)
        }
    }
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
