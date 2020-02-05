import Base32Crockford
import UIKit

enum IdentifierDataTypeName: CustomStringConvertible {
  case `default`
  case uuid
  case bytes
  case minimumCount

  var description: String {
    switch self {
    case .bytes:
      return "Bytes"
    case .uuid:
      return "UUID"
    case .minimumCount:
      return "Minimum Count"
    default:
      return "Default"
    }
  }
}

enum IdentifierDataIntName {
  case bytes
  case minimumCount
}

struct IdentifierDataTypeParameter: CaseIterable, CustomStringConvertible {
  static let allCases = [
    IdentifierDataTypeParameter(type: .bytes, integerName: .bytes),
    IdentifierDataTypeParameter(type: .default, integerName: nil),
    IdentifierDataTypeParameter(type: .uuid, integerName: nil),
    IdentifierDataTypeParameter(type: .minimumCount, integerName: .minimumCount)
  ]

  let type: IdentifierDataTypeName
  let integerName: IdentifierDataIntName?

  var description: String {
    return type.description
  }
}

class IdentifierDataTypeTableViewController: UITableViewController {
  let encoding = Base32CrockfordEncoding.encoding
  override func viewDidLoad() {
    super.viewDidLoad()

    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem

    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
  }

  // MARK: - Table view data source

  override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return IdentifierDataTypeParameter.allCases.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

    // Configure the cell...
    cell.textLabel?.text = IdentifierDataTypeParameter.allCases[indexPath.row].description

    return cell
  }

  override func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
    let parameter = IdentifierDataTypeParameter.allCases[indexPath.row]
    if let navViewController = navigationController, let integerName = parameter.integerName {
      let viewController = IntegerCountViewController()
      viewController.integerName = integerName
      viewController.generate = generate
      navViewController.pushViewController(viewController, animated: true)
    } else {
      let idType: IdentifierDataType?
      switch parameter.type {
      case .default:
        idType = .default
      case .uuid:
        idType = .uuid
      default:
        idType = nil
      }

      guard let actualType = idType else {
        return
      }
      let value = generate(basedOn: actualType)
      let controller = UIAlertController(title: actualType.description, message: value, preferredStyle: .alert)
      controller.addAction(UIAlertAction(title: "OK", style: .default,
                                         handler: { _ in
                                           controller.dismiss(animated: true)
        }))
      present(controller, animated: true)
    }
  }

  func generate(basedOn type: IdentifierDataType) -> String {
    return encoding.generateIdentifier(from: type)
  }

  /*
   // Override to support conditional editing of the table view.
   override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
       // Return false if you do not want the specified item to be editable.
       return true
   }
   */

  /*
   // Override to support editing the table view.
   override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
       if editingStyle == .delete {
           // Delete the row from the data source
           tableView.deleteRows(at: [indexPath], with: .fade)
       } else if editingStyle == .insert {
           // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
       }
   }
   */

  /*
   // Override to support rearranging the table view.
   override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

   }
   */

  /*
   // Override to support conditional rearranging of the table view.
   override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
       // Return false if you do not want the item to be re-orderable.
       return true
   }
   */

  /*
   // MARK: - Navigation

   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       // Get the new view controller using segue.destination.
       // Pass the selected object to the new view controller.
   }
   */
}
