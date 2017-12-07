package ex5;

/**
 * Created by aleksandr on 20.11.2017.
 */
public class LLElement<T> {
    private T data;
    private LLElement<T> next;

    public LLElement() {
        this(null, null);
    }

    public LLElement(T data) {
        this(data, null);
    }

    public LLElement(T data, LLElement<T> next) {
        this.data = data;
        this.next = next;
    }

    public void setData(T data) {
        this.data = data;
    }

    public T getData() {
        return this.data;
    }

    public void setNext(LLElement<T> next) {
        this.next = next;
    }

    public LLElement<T> getNext() {
        return this.next;
    }
}
