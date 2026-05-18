package service;

import dao.Shopdao;
import model.Shop;
import java.util.*;

public class ShopService
{
    Shopdao dao=new Shopdao();
    public void createShop(Shop s)
    {
        if (dao.existsByName(s.getName()))
        {
            System.out.println("Loi: Ten shop da ton tai!");
            return;
        }
        if(s.getName()==null || s.getName().trim().isEmpty() )
        {
            System.out.println("Ten khong hop le");
            return;
        }
        if(s.getAddress()==null || s.getAddress().trim().isEmpty() )
        {
            System.out.println("Dia chi khong hop le");
            return;
        }
        if(s.getDescription()==null || s.getDescription().trim().isEmpty() )
        {
            System.out.println("Vui long nhap mieu ta");
            return;
        }
        dao.add(s);
    }
    public List<Shop> getAll()
    {
        return dao.getAll();
    }
    public void update(Shop s)
    {
        dao.update(s);
    }
    public void close(int id)
    {
        dao.close(id);
    }
    public void reopen(int id)
    {
        dao.reopen(id);
    }
    public void remove(int id)
    {
        dao.removeShop(id);
    }
}