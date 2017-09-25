# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
 def  insertionsort(num)
      final = [num[0]]
      num.delete_at(0)
      for i in num
        index = 0
        while index < final.size do
          if i < final[index]
            final.insert(index, i)
            break
          elsif index == (final.size - 1)
            final.insert(index+1, i)
            break
          end
          index += 1
        end
      end
      print final.join(' ')
    end

    def print_arr(arr)
      out = ""
      arr.each { |item| out += item.to_s + " " }
      puts out
    end

    def insertionSort(ar)
      for j in 1..(ar.length - 1)
        key = ar[j]
        i = j - 1
        while i >= 0 and ar[i] > key
          p "---- #{i}"
          print_arr(ar)
          ar[i+1] = ar[i]
          i = i - 1
        end
        ar[i+1] = key
      end
      print_arr(ar)
    end
