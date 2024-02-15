package com.bambo.pizza.persitence.repository;

import com.bambo.pizza.persitence.entity.PizzaEntity;
import com.bambo.pizza.service.PizzaService;
import com.bambo.pizza.service.dto.UpdatePizzaPriceDto;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.ListCrudRepository;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface PizzaRepository extends ListCrudRepository<PizzaEntity, Integer>{

    List<PizzaEntity> findAllByAvailableTrueOrderByPrice();
   /** PizzaEntity findAllByAvailableTrueAndNameIgnoreCase(String name);*/
   Optional<PizzaEntity> findFirstByAvailableTrueAndNameIgnoreCase(String name);

    List<PizzaEntity> findAllByAvailableTrueAndDescriptionContainingIgnoreCase(String description);
    List<PizzaEntity> findAllByAvailableTrueAndDescriptionNotContainingIgnoreCase(String description);

    List<PizzaEntity> findTop3ByAvailableTrueAndPriceLessThanEqualOrderByPriceAsc(double price);

    int countByVeganTrue();

    @Query(value =
            "UPDATE pizza " +
                    "SET price = :#{#newPizzaPrice.newPrice} " +
                    "WHERE id_pizza = :#{#newPizzaPrice.pizzaId}", nativeQuery = true)
    @Modifying
    void updatePrice(@Param("newPizzaPrice") UpdatePizzaPriceDto newPizzaPrice);

}
