import java.util.ArrayList;
public class MergeSortSnek {
  private static ArrayList<Starui.Snek> merge( ArrayList<Starui.Snek> a, ArrayList<Starui.Snek> b ) {
    int curA = 0, curB = 0;
    ArrayList<Starui.Snek> retArr = new ArrayList<Starui.Snek>();
    while (curA < a.size() && curB < b.size()) {
      if (a.get(curA).compareTo(b.get(curB)) <= 0) {
        retArr.add(a.get(curA));
        curA++;
      } else {
        retArr.add(b.get(curB));
        curB++;
      }
    }
    while (curA < a.size()) {
      retArr.add(a.get(curA));
      curA++;
    }
    while (curB < b.size()) {
      retArr.add(b.get(curB));
      curB++;
    }
    return retArr;
  }//end merge()

  public static ArrayList sort( ArrayList<Starui.Snek> arr ) {
    if (arr.size() == 1 || arr.size() == 0) return arr;
    else {
      ArrayList firstHalf = new ArrayList(), otherHalf = new ArrayList();
      for (int i = 0; i<arr.size()/2; i++)
        firstHalf.add(arr.get(i));
      for (int i = firstHalf.size(); i < arr.size(); i++)
        otherHalf.add(arr.get(i));
      return merge(sort(firstHalf), sort(otherHalf));
    }
  }//end sort()
}//end class MergeSort