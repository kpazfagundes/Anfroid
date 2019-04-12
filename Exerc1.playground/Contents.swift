import Foundation

struct Point{
    let x: Double
    let y: Double
    
    func distance(from
        point: Point) ->
        Double {
            let result = sqrt(
                pow((point.x - self.x),2)+pow((point.y - self.y),2)
            )
            return result.roundTo(places: 2)
    }
    
}
struct Triangulo{
    enum Kind {
        case equilateral
        case isosceles
        case scaleno
    }
    
    let vertx1: Point
    let vertx2: Point
    let vertx3: Point
    
    var kind: Kind{
        let ab=vertx1.distance(from: vertx2)
        let ac=vertx1.distance(from: vertx3)
        let bc=vertx2.distance(from: vertx3)
        
        if ab == ac && bc == ac{
            return .equilateral
        }else if ab == ac || ab == bc || ac == bc{
            return .isosceles
        }else { return .scaleno }
        
    }
}

extension Double {
    func roundTo(places: Int) -> Double{
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
}

let a1 = Point(x:2, y:7)
let b1 = Point(x:2, y:3)
let c1 = Point(x:5, y:3)

let a2 = Point(x:2, y:3)
let b2 = Point(x:2, y:1)
let c2 = Point(x:4, y:1)


let a3 = Point(x:5, y:7)
let b3 = Point(x:10, y:9)
let c3 = Point(x:5.768, y:12.33)

let triangulo1 = Triangulo(vertx1: a1, vertx2: b1, vertx3: c1)
let triangulo2 = Triangulo(vertx1: a2, vertx2: b2, vertx3: c2)
let triangulo3 = Triangulo(vertx1: a3, vertx2: b3, vertx3: c3)

print("Triangulo 1 \(triangulo1.kind)")
print("Triangulo 2 \(triangulo2.kind)")
print("Triangulo 3 \(triangulo3.kind)")

